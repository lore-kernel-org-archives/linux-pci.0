Return-Path: <SRS0=srx4=WX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9D4C3A5A3
	for <linux-pci@archiver.kernel.org>; Tue, 27 Aug 2019 23:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F419214DA
	for <linux-pci@archiver.kernel.org>; Tue, 27 Aug 2019 23:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566947834;
	bh=LHYP3wO1EM0CN7MZnuQ9uyPpTSuaC669PEWoJvNcjA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YLuNf6116InIR/zGtPvgzseVz+yMsgUs+PYLpeAhyM0Quc/co3dVDDxP2wedUnsb9
	 t/YNph4prfMtFDvY5W17sRJpk7WOAj/zr13d6AhdqGJEqwh3poAi0krWRmCfYtLJye
	 6asiMLPD0yuH9aAlbTOgbbmwBq+OfqJ9j87Z7uas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfH0XRO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfH0XRN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 19:17:13 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F35DA20856;
        Tue, 27 Aug 2019 23:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566947832;
        bh=LHYP3wO1EM0CN7MZnuQ9uyPpTSuaC669PEWoJvNcjA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wp2G22s2JiRw967LPOtC7TV8P1ym933f60GQCuP9jTKdhOqTI6+p5eZAJ0ic5NX6J
         6mH+po7knLNM01dxN+2SAHO5hLA6asmWU0K7y+bFR6YVV+IX0UL+xFzf9QXIKCKS0E
         LKK8hS8bnaKMHqrjAQF1xXI9iqvvNL0h0qE3zUUc=
Date:   Tue, 27 Aug 2019 18:17:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Scott Murray <scott@spiteful.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PCI: hotplug: Remove surplus return from a void function
Message-ID: <20190827231710.GH9987@google.com>
References: <20190826095143.21353-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826095143.21353-1-kw@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 26, 2019 at 11:51:43AM +0200, Krzysztof Wilczynski wrote:
> Remove unnecessary empty return statement at the end of a void
> function in the following:
> 
>   - drivers/pci/hotplug/cpci_hotplug_core.c: cleanup_slots()
>   - drivers/pci/hotplug/cpqphp_core.c: pci_print_IRQ_route()
>   - drivers/pci/hotplug/cpqphp_ctrl.c: cpqhp_pushbutton_thread()
>   - drivers/pci/hotplug/cpqphp_ctrl.c: interrupt_event_handler()
>   - drivers/pci/hotplug/cpqphp_nvram.h: compaq_nvram_init()
>   - drivers/pci/hotplug/rpadlpar_core.c: rpadlpar_io_init()
>   - drivers/pci/hotplug/rpaphp_core.c: cleanup_slots()
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>

Applied to pci/trivial for v5.4, thanks!

I squashed the mediatek patch into this since they're both trivial.

> ---
>  drivers/pci/hotplug/cpci_hotplug_core.c | 1 -
>  drivers/pci/hotplug/cpqphp_core.c       | 1 -
>  drivers/pci/hotplug/cpqphp_ctrl.c       | 4 ----
>  drivers/pci/hotplug/cpqphp_nvram.h      | 5 +----
>  drivers/pci/hotplug/rpadlpar_core.c     | 1 -
>  drivers/pci/hotplug/rpaphp_core.c       | 1 -
>  6 files changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
> index 603eadf3d965..d0559d2faf50 100644
> --- a/drivers/pci/hotplug/cpci_hotplug_core.c
> +++ b/drivers/pci/hotplug/cpci_hotplug_core.c
> @@ -563,7 +563,6 @@ cleanup_slots(void)
>  	}
>  cleanup_null:
>  	up_write(&list_rwsem);
> -	return;
>  }
>  
>  int
> diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
> index 16bbb183695a..b8aacb41a83c 100644
> --- a/drivers/pci/hotplug/cpqphp_core.c
> +++ b/drivers/pci/hotplug/cpqphp_core.c
> @@ -173,7 +173,6 @@ static void pci_print_IRQ_route(void)
>  		dbg("%d %d %d %d\n", tbus, tdevice >> 3, tdevice & 0x7, tslot);
>  
>  	}
> -	return;
>  }
>  
>  
> diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
> index b7f4e1f099d9..68de958a9be8 100644
> --- a/drivers/pci/hotplug/cpqphp_ctrl.c
> +++ b/drivers/pci/hotplug/cpqphp_ctrl.c
> @@ -1872,8 +1872,6 @@ static void interrupt_event_handler(struct controller *ctrl)
>  			}
>  		}		/* End of FOR loop */
>  	}
> -
> -	return;
>  }
>  
>  
> @@ -1943,8 +1941,6 @@ void cpqhp_pushbutton_thread(struct timer_list *t)
>  
>  		p_slot->state = STATIC_STATE;
>  	}
> -
> -	return;
>  }
>  
>  
> diff --git a/drivers/pci/hotplug/cpqphp_nvram.h b/drivers/pci/hotplug/cpqphp_nvram.h
> index 918ff8dbfe62..70e879b6a23f 100644
> --- a/drivers/pci/hotplug/cpqphp_nvram.h
> +++ b/drivers/pci/hotplug/cpqphp_nvram.h
> @@ -16,10 +16,7 @@
>  
>  #ifndef CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM
>  
> -static inline void compaq_nvram_init(void __iomem *rom_start)
> -{
> -	return;
> -}
> +static inline void compaq_nvram_init(void __iomem *rom_start) { }
>  
>  static inline int compaq_nvram_load(void __iomem *rom_start, struct controller *ctrl)
>  {
> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> index 182f9e3443ee..977946e4e613 100644
> --- a/drivers/pci/hotplug/rpadlpar_core.c
> +++ b/drivers/pci/hotplug/rpadlpar_core.c
> @@ -473,7 +473,6 @@ int __init rpadlpar_io_init(void)
>  void rpadlpar_io_exit(void)
>  {
>  	dlpar_sysfs_exit();
> -	return;
>  }
>  
>  module_init(rpadlpar_io_init);
> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
> index c3899ee1db99..18627bb21e9e 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -408,7 +408,6 @@ static void __exit cleanup_slots(void)
>  		pci_hp_deregister(&slot->hotplug_slot);
>  		dealloc_slot_struct(slot);
>  	}
> -	return;
>  }
>  
>  static int __init rpaphp_init(void)
> -- 
> 2.22.1
> 
