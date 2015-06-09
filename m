Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aba15cd979bc3523c0289f4766b47d3f45f32c38.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com> <aba15cd979bc3523c0289f4766b47d3f45f32c38.1433838377.git.Allen.Hubbe@emc.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 9 Jun 2015 11:04:46 -0500
Message-ID: <CAErSpo7B8qP34ZObkzjZ-r7bCnG6A0KG3Rorw+TajP4XU43wFg@mail.gmail.com>
Subject: Re: [PATCH v3 18/18] NTB: Increase transport MTU to 64k from 16k
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 9, 2015 at 4:44 AM, Allen Hubbe <Allen.Hubbe@emc.com> wrote:
> From: Dave Jiang <dave.jiang@intel.com>
>
> Benchmarking showed significant performance increase going from MTU size
> of 64k from 16k.  Changing the default.

This changelog doesn't parse.  I think you mean "going from MTU size
16k to 64k."

The original value was 0x401e (16k + 0x1e), and the new value is
exactly 64k.  Please include a note about what that extra 0x1e was for
and why it isn't needed in the new value.

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/ntb/ntb_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index ea237aeca28c..c87bc0cbd607 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -76,7 +76,7 @@ static unsigned long max_mw_size;
>  module_param(max_mw_size, ulong, 0644);
>  MODULE_PARM_DESC(max_mw_size, "Limit size of large memory windows");
>
> -static unsigned int transport_mtu = 0x401E;
> +static unsigned int transport_mtu = 0x10000;
>  module_param(transport_mtu, uint, 0644);
>  MODULE_PARM_DESC(transport_mtu, "Maximum size of NTB transport packets");
>
> --
> 2.4.0.rc0.43.gcf8a8c6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
