Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AA54502F;
	Tue, 24 Feb 2026 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946564; cv=none; b=C9zoyJQjsPjdw7poHdy01FI999Xwda7l/pC8yGgIPmqRFsE/ONnFyCu1X2ENB//2LQsAadPIXUkkr3NKJrdqWNMjSdaJC7dQaqOae6Ef9/RnNMoZSwHMOMtz5sHBlp81z/vcvMt8t9kBJi3D98fcfU9OUZjsAOJ90CynvXjHFCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946564; c=relaxed/simple;
	bh=9F21oVqzbvLNHIWD/OjKzGXyzUqKNTyNYw5SNri/3QY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FHV6Q5y+tmdRy0Rgc5OMHv4gMZNy39S5dqDmM2qYUW9dgIjp0jgHNRQO6BJJBGPuUpXWV2feby1UoCM5TFck3703h6UZgoqJP6KfeCWWwFIgXxnL4Wfxt5TarFbzLJDPMjvJPF6hcXGTWZyL++HHLKZcSsAiXqACTgq+ANnSZMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DmC4mOkq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DmC4mOkq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771946562; x=1803482562;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9F21oVqzbvLNHIWD/OjKzGXyzUqKNTyNYw5SNri/3QY=;
  b=DmC4mOkq1agK4oGPNsHlhmzuo8Ds94UBH3/byf14qn7EjKR/Zm8clQOY
   3M23CCZ1lfWY9WoCqAcr3zZklw/qG+nKOoqpt/fqkL2J9fYYgxIxjgERY
   C0mjbuQBTrHO1alKoX41sKCiOm49UWmGxc1fo7e1ieAR84ycqDAz/iPnW
   VuqiV/g95hvfqXIMj1WVg5bvG5HI1642JUhnRr5mErV9GzrkHJrNLEykF
   0Hlmyvx3f2fJtbj4M8tuNr5CVFkFObmG3hoP95o4w+bA7Y7hb9SELA41c
   +GkibBdUQsOY6RCQ6ntyqWs1NDA5qL80nuByu1ilCB20NkH9NiXZDcHen
   A==;
X-CSE-ConnectionGUID: SiAJepWyTS2Uom366Dk3xQ==
X-CSE-MsgGUID: W9rtYNY5SY+g94QJ24Zm0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72839084"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="72839084"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 07:22:42 -0800
X-CSE-ConnectionGUID: xBpYYwWcTnKhslgK8BYInQ==
X-CSE-MsgGUID: w9D/pvx7Romiu0gepzECYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="238928420"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.133])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 07:22:38 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 24 Feb 2026 17:22:35 +0200 (EET)
To: Shawn Lin <shawn.lin@rock-chips.com>
cc: Manivannan Sadhasivam <mani@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-rockchip@lists.infradead.org, 
    linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
    linux-doc@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 1/3] PCI: trace: Add PCI controller LTSSM transition
 tracepoint
In-Reply-To: <1769047340-113287-2-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <7d195f03-978a-2d0d-acdf-e583e68377f2@linux.intel.com>
References: <1769047340-113287-1-git-send-email-shawn.lin@rock-chips.com> <1769047340-113287-2-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 22 Jan 2026, Shawn Lin wrote:

> Some platforms may provide LTSSM trace functionality, recording historical
> LTSSM state transition information. This is very useful for debugging, such
> as when certain devices cannot be recognized or link broken during test.
> Implement the pci controller tracepoint for recording LTSSM and rate.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v4:
> - use TRACE_EVENT_FN to notify when to start and stop the tracepoint,
>   and export pci_ltssm_tp_enabled() for host drivers to use
> 
> Changes in v3:
> - add TRACE_DEFINE_ENUM for all enums(Steven Rostedt)
> 
> Changes in v2: None
> 
>  drivers/pci/trace.c                   | 20 ++++++++++++
>  include/linux/pci.h                   |  4 +++
>  include/trace/events/pci_controller.h | 57 +++++++++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+)
>  create mode 100644 include/trace/events/pci_controller.h
> 
> diff --git a/drivers/pci/trace.c b/drivers/pci/trace.c
> index cf11abc..d351a51 100644
> --- a/drivers/pci/trace.c
> +++ b/drivers/pci/trace.c
> @@ -9,3 +9,23 @@
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/pci.h>
> +#include <trace/events/pci_controller.h>
> +
> +static atomic_t pcie_ltssm_tp_enabled = ATOMIC_INIT(0);
> +
> +bool pci_ltssm_tp_enabled(void)
> +{
> +	return atomic_read(&pcie_ltssm_tp_enabled) > 0;
> +}
> +EXPORT_SYMBOL(pci_ltssm_tp_enabled);
> +
> +int pci_ltssm_tp_reg(void)
> +{
> +	atomic_inc(&pcie_ltssm_tp_enabled);
> +	return 0;
> +}
> +
> +void pci_ltssm_tp_unreg(void)
> +{
> +	atomic_dec(&pcie_ltssm_tp_enabled);
> +}
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e7cb527..ac25a3e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2770,6 +2770,10 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
>  }
>  #endif
>  
> +#ifdef CONFIG_TRACING
> +bool pci_ltssm_tp_enabled(void);
> +#endif
> +
>  void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned nr_devfns);
>  bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2);
>  int pci_for_each_dma_alias(struct pci_dev *pdev,
> diff --git a/include/trace/events/pci_controller.h b/include/trace/events/pci_controller.h
> new file mode 100644
> index 0000000..db4a960
> --- /dev/null
> +++ b/include/trace/events/pci_controller.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM pci_controller

I find putting this into "pci_controller" little odd as LTSSM is related 
to PCIe links/ports. To me looks something that belongs to the existing 
include/trace/events/pci.h.

> +#if !defined(_TRACE_HW_EVENT_PCI_CONTROLLER_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_HW_EVENT_PCI_CONTROLLER_H
> +
> +#include <uapi/linux/pci_regs.h>
> +#include <linux/tracepoint.h>
> +
> +TRACE_DEFINE_ENUM(PCIE_SPEED_2_5GT);
> +TRACE_DEFINE_ENUM(PCIE_SPEED_5_0GT);
> +TRACE_DEFINE_ENUM(PCIE_SPEED_8_0GT);
> +TRACE_DEFINE_ENUM(PCIE_SPEED_16_0GT);
> +TRACE_DEFINE_ENUM(PCIE_SPEED_32_0GT);
> +TRACE_DEFINE_ENUM(PCIE_SPEED_64_0GT);
> +TRACE_DEFINE_ENUM(PCI_SPEED_UNKNOWN);
> +
> +extern int pci_ltssm_tp_reg(void);
> +extern void pci_ltssm_tp_unreg(void);
> +
> +TRACE_EVENT_FN(pcie_ltssm_state_transition,
> +	TP_PROTO(const char *dev_name, const char *state, u32 rate),
> +	TP_ARGS(dev_name, state, rate),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name)
> +		__string(state, state)
> +		__field(u32, rate)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name);
> +		__assign_str(state);
> +		__entry->rate = rate;
> +	),
> +
> +	TP_printk("dev: %s state: %s rate: %s",
> +		__get_str(dev_name), __get_str(state),
> +		__print_symbolic(__entry->rate,
> +			{ PCIE_SPEED_2_5GT,  "2.5 GT/s" },
> +			{ PCIE_SPEED_5_0GT,  "5.0 GT/s" },
> +			{ PCIE_SPEED_8_0GT,  "8.0 GT/s" },
> +			{ PCIE_SPEED_16_0GT, "16.0 GT/s" },
> +			{ PCIE_SPEED_32_0GT, "32.0 GT/s" },
> +			{ PCIE_SPEED_64_0GT, "64.0 GT/s" },
> +			{ PCI_SPEED_UNKNOWN, "Unknown" }

Why are these done inline instead of using EM/EMe()? Or simply with
pci_speed_string()?


Unrelated to this, sadly I failed to notice Shuai's version of 
pcie_link_event() did not translate link speeds (my own version used 
pci_speed_string()).

> +		)
> +	),
> +
> +	pci_ltssm_tp_reg, pci_ltssm_tp_unreg
> +);
> +
> +#endif /* _TRACE_HW_EVENT_PCI_CONTROLLER_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> 

-- 
 i.

