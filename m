Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37315C282DA
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 22:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F187F2184B
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 22:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555541342;
	bh=TP8skHcSw4kJ4SHsammlirpYr7t+TKp7R9s/GWQwwGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2WzKwBVRJ7SP0z0UszKNPwG5iZwwXeVx+SohYabbfjJPp1Oz+wXw8i4dHzTb9HT8d
	 Z+J7TGIsY6boDQpZlnG7shkKXgUfeHUmNOs8BkqwM0y3mYi5LD+t9oUt5rc3WmSjbV
	 0858FHilhnwZA9QpJRhtGlZk1hTiyepJwT7FHXxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbfDQWtB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:49:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbfDQWtB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Apr 2019 18:49:01 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CB20217D7;
        Wed, 17 Apr 2019 22:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555541339;
        bh=TP8skHcSw4kJ4SHsammlirpYr7t+TKp7R9s/GWQwwGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WavB5CuOYUBUZeydjMh1tvO2jcC+NH+pZgONNcAEnFaw5WAYypNeLuU55hNC3PIVi
         P2mvx6B0sKx8Q+LFx5S9Yy8rdeeCPpaIV3prmkymWN345HqvH0xJiMwVu+oY29Ygz+
         rmN+x9KIaKoMBV8DlrgQWiMBEB+T7ee6zkTsTPa8=
Date:   Wed, 17 Apr 2019 17:48:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wesley Sheng <wesley.sheng@microchip.com>
Cc:     kurt.schwemmer@microsemi.com, logang@deltatee.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        wesleyshenggit@sina.com
Subject: Re: [PATCH v2 1/2] switchtec: Fix false maximum supported PCIe
 function number issue
Message-ID: <20190417224858.GW126710@google.com>
References: <1555339302-31829-1-git-send-email-wesley.sheng@microchip.com>
 <1555339302-31829-2-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555339302-31829-2-git-send-email-wesley.sheng@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 15, 2019 at 10:41:41PM +0800, Wesley Sheng wrote:
> The hardware supports up to 255 PFFs and the driver only supports 48, so
> this patch updates the driver to support them all. To be backward
> compatible, a new ioctl and corresponding data structure are created,
> while keep the deprecated one.

The commit log needs to include some kind of detail about what "PFF"
is.  Logan provided the following, which looks like a good starting
point:

  PFF is really a concept internal to the Switchtec device. It stands
  for PCIe Function Framework. Essentially, there is a bank of
  registers for every PCIe Function (aka endpoint) in the switch. When
  I originally wrote the driver, I assumed incorrectly there would
  only ever be one PFF per port and the maximum number of ports for
  Switchtec parts is 48. In fact, the hardware supports up to 255 and
  there are typically two PFFs per upstream port (one for the port
  itself and one for the management endpoint).

I had a couple minor questions below that aren't exactly related to
this patch.  If you did decide to address them (in a separate patch,
of course), you could expand the commit log for this patch with the
PFF info.  If the questions below don't need anything, I can
incorporate something about PFF myself.

> ---
>  drivers/pci/switch/switchtec.c       | 39 +++++++++++++++++++++++++-----------
>  include/linux/switchtec.h            |  2 +-
>  include/uapi/linux/switchtec_ioctl.h | 13 +++++++++++-
>  3 files changed, 40 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index e22766c..7df9a69 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -658,19 +658,25 @@ static int ioctl_flash_part_info(struct switchtec_dev *stdev,
>  
>  static int ioctl_event_summary(struct switchtec_dev *stdev,
>  	struct switchtec_user *stuser,
> -	struct switchtec_ioctl_event_summary __user *usum)
> +	struct switchtec_ioctl_event_summary __user *usum,
> +	size_t size)
>  {
> -	struct switchtec_ioctl_event_summary s = {0};
> +	struct switchtec_ioctl_event_summary *s;
>  	int i;
>  	u32 reg;
> +	int ret = 0;
>  
> -	s.global = ioread32(&stdev->mmio_sw_event->global_summary);
> -	s.part_bitmap = ioread32(&stdev->mmio_sw_event->part_event_bitmap);
> -	s.local_part = ioread32(&stdev->mmio_part_cfg->part_event_summary);
> +	s = kzalloc(sizeof(*s), GFP_KERNEL);
> +	if (!s)
> +		return -ENOMEM;
> +
> +	s->global = ioread32(&stdev->mmio_sw_event->global_summary);
> +	s->part_bitmap = ioread32(&stdev->mmio_sw_event->part_event_bitmap);
> +	s->local_part = ioread32(&stdev->mmio_part_cfg->part_event_summary);
>  
>  	for (i = 0; i < stdev->partition_count; i++) {
>  		reg = ioread32(&stdev->mmio_part_cfg_all[i].part_event_summary);
> -		s.part[i] = reg;
> +		s->part[i] = reg;
>  	}
>  
>  	for (i = 0; i < SWITCHTEC_MAX_PFF_CSR; i++) {

Should this be "i < stdev->pff_csr_count", as in
check_link_state_events(), enable_link_state_events() and
mask_all_events()?  If so, I assume the read and check of vendor_id
would be unnecessary?

The last loop in init_pff() currently checks against
SWITCHTEC_MAX_PFF_CSR:

        for (i = 0; i < ARRAY_SIZE(pcfg->dsp_pff_inst_id); i++) {
                reg = ioread32(&pcfg->dsp_pff_inst_id[i]);
                if (reg < SWITCHTEC_MAX_PFF_CSR)
                        stdev->pff_local[reg] = 1;
        }

Should it check "reg < stdev->pff_csr_count" instead?  It looks like
mask_all_events(), the only reader of pff_local[], only looks up to
pff_csr_count anyway.

> @@ -679,15 +685,19 @@ static int ioctl_event_summary(struct switchtec_dev *stdev,
>  			break;
>  
>  		reg = ioread32(&stdev->mmio_pff_csr[i].pff_event_summary);
> -		s.pff[i] = reg;
> +		s->pff[i] = reg;
>  	}
>  
> -	if (copy_to_user(usum, &s, sizeof(s)))
> -		return -EFAULT;
> +	if (copy_to_user(usum, s, size)) {
> +		ret = -EFAULT;
> +		goto error_case;
> +	}
>  
>  	stuser->event_cnt = atomic_read(&stdev->event_cnt);
>  
> -	return 0;
> +error_case:
> +	kfree(s);
> +	return ret;
>  }
>  
>  static u32 __iomem *global_ev_reg(struct switchtec_dev *stdev,
> @@ -977,8 +987,9 @@ static long switchtec_dev_ioctl(struct file *filp, unsigned int cmd,
>  	case SWITCHTEC_IOCTL_FLASH_PART_INFO:
>  		rc = ioctl_flash_part_info(stdev, argp);
>  		break;
> -	case SWITCHTEC_IOCTL_EVENT_SUMMARY:
> -		rc = ioctl_event_summary(stdev, stuser, argp);
> +	case SWITCHTEC_IOCTL_EVENT_SUMMARY_LEGACY:
> +		rc = ioctl_event_summary(stdev, stuser, argp,
> +					 sizeof(struct switchtec_ioctl_event_summary_legacy));
>  		break;
>  	case SWITCHTEC_IOCTL_EVENT_CTL:
>  		rc = ioctl_event_ctl(stdev, argp);
> @@ -989,6 +1000,10 @@ static long switchtec_dev_ioctl(struct file *filp, unsigned int cmd,
>  	case SWITCHTEC_IOCTL_PORT_TO_PFF:
>  		rc = ioctl_port_to_pff(stdev, argp);
>  		break;
> +	case SWITCHTEC_IOCTL_EVENT_SUMMARY:
> +		rc = ioctl_event_summary(stdev, stuser, argp,
> +					 sizeof(struct switchtec_ioctl_event_summary));
> +		break;
>  	default:
>  		rc = -ENOTTY;
>  		break;
> diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
> index 52a079b..0cfc34a 100644
> --- a/include/linux/switchtec.h
> +++ b/include/linux/switchtec.h
> @@ -20,7 +20,7 @@
>  #include <linux/cdev.h>
>  
>  #define SWITCHTEC_MRPC_PAYLOAD_SIZE 1024
> -#define SWITCHTEC_MAX_PFF_CSR 48
> +#define SWITCHTEC_MAX_PFF_CSR 255
>  
>  #define SWITCHTEC_EVENT_OCCURRED BIT(0)
>  #define SWITCHTEC_EVENT_CLEAR    BIT(0)
> diff --git a/include/uapi/linux/switchtec_ioctl.h b/include/uapi/linux/switchtec_ioctl.h
> index 4f4daf8..c912b5a 100644
> --- a/include/uapi/linux/switchtec_ioctl.h
> +++ b/include/uapi/linux/switchtec_ioctl.h
> @@ -50,7 +50,7 @@ struct switchtec_ioctl_flash_part_info {
>  	__u32 active;
>  };
>  
> -struct switchtec_ioctl_event_summary {
> +struct switchtec_ioctl_event_summary_legacy {
>  	__u64 global;
>  	__u64 part_bitmap;
>  	__u32 local_part;
> @@ -59,6 +59,15 @@ struct switchtec_ioctl_event_summary {
>  	__u32 pff[48];
>  };
>  
> +struct switchtec_ioctl_event_summary {
> +	__u64 global;
> +	__u64 part_bitmap;
> +	__u32 local_part;
> +	__u32 padding;
> +	__u32 part[48];
> +	__u32 pff[255];
> +};
> +
>  #define SWITCHTEC_IOCTL_EVENT_STACK_ERROR		0
>  #define SWITCHTEC_IOCTL_EVENT_PPU_ERROR			1
>  #define SWITCHTEC_IOCTL_EVENT_ISP_ERROR			2
> @@ -127,6 +136,8 @@ struct switchtec_ioctl_pff_port {
>  	_IOWR('W', 0x41, struct switchtec_ioctl_flash_part_info)
>  #define SWITCHTEC_IOCTL_EVENT_SUMMARY \
>  	_IOR('W', 0x42, struct switchtec_ioctl_event_summary)
> +#define SWITCHTEC_IOCTL_EVENT_SUMMARY_LEGACY \
> +	_IOR('W', 0x42, struct switchtec_ioctl_event_summary_legacy)
>  #define SWITCHTEC_IOCTL_EVENT_CTL \
>  	_IOWR('W', 0x43, struct switchtec_ioctl_event_ctl)
>  #define SWITCHTEC_IOCTL_PFF_TO_PORT \
> -- 
> 2.7.4
> 
