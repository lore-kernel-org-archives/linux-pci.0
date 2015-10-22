Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 22 Oct 2015 15:36:50 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: bhelgaas@google.com, carolyn.wyborny@intel.com,
	donald.c.skidmore@intel.com, eddie.dong@intel.com,
	nrupal.jani@intel.com, yang.z.zhang@intel.com, agraf@suse.de,
	kvm@vger.kernel.org, pbonzini@redhat.com, qemu-devel@nongnu.org,
	emil.s.tantilov@intel.com, intel-wired-lan@lists.osuosl.org,
	jeffrey.t.kirsher@intel.com, jesse.brandeburg@intel.com,
	john.ronciak@intel.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, matthew.vick@intel.com,
	mitch.a.williams@intel.com, netdev@vger.kernel.org,
	shannon.nelson@intel.com
Subject: Re: [RFC Patch 11/12] IXGBEVF: Migrate VF statistic data
Message-ID: <20151022153330-mutt-send-email-mst@redhat.com>
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
 <1445445464-5056-12-git-send-email-tianyu.lan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445445464-5056-12-git-send-email-tianyu.lan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 22, 2015 at 12:37:43AM +0800, Lan Tianyu wrote:
> VF statistic regs are read-only and can't be migrated via writing back
> directly.
> 
> Currently, statistic data returned to user space by the driver is not equal
> to value of statistic regs. VF driver records value of statistic regs as base data
> when net interface is up or open, calculate increased count of regs during
> last period of online service and added it to saved_reset data. When user
> space collects statistic data, VF driver returns result of
> "current - base + saved_reset". "Current" is reg value at that point.
> 
> Restoring net function after migration just likes net interface is up or open.
> Call existed function to update base and saved_reset data to keep statistic
> data continual during migration.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index 04b6ce7..d22160f 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -3005,6 +3005,7 @@ int ixgbevf_live_mg(struct ixgbevf_adapter *adapter)
>  			return 0;
>  
>  		del_timer_sync(&adapter->service_timer);
> +		ixgbevf_update_stats(adapter);
>  		pr_info("migration start\n");
>  		migration_status = MIGRATION_IN_PROGRESS; 
>  

So far, it seems that the only two things done when
starting migration are very small.

It doesn't seem worth it to let guests defer migration for things like
this.  Surely, cancelling a timer can be done later after VM is
migrated?



> @@ -3017,6 +3018,8 @@ int ixgbevf_live_mg(struct ixgbevf_adapter *adapter)
>  			return 1;
>  
>  		ixgbevf_restore_state(adapter);
> +		ixgbevf_save_reset_stats(adapter);
> +		ixgbevf_init_last_counter_stats(adapter);
>  		migration_status = MIGRATION_COMPLETED;
>  		pr_info("migration end\n");
>  		return 0;
> -- 
> 1.8.4.rc0.1.g8f6a3e5.dirty
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
