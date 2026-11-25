Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613754;
	b=fjKkFXlyR9pfVYkuOBVGHWFGke1AwT6YE+rjmgs0/YAr7mTwwVPXhPUcNIeMQRC+Iut2
	 JGCUMUmTpRDbHEf8St6QTDpiRTpQSprSwSkcJBeoi+9/zuXD+68n3LylofXJnSBa0LLnW
	 +nHZkrgBPDzCq4NCZfzO4oxByq8tQAzSIvp5T50N1HJZIf+pc/2ar3RZci4y866+p5w6x
	 yx7dPzmsiUTtddlEuktl+rB7g6l7S4ct/pXUREMZ8bwYYt+XaVauoA8D5EVGaG3YJK5pY
	 VOhSxqa58xnU7UPG+a3OkHI5QBToYCMlxnZAqD4V5i8wixdb3PJpw/h3QSTjRDZnm9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613754;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=sMVLaCsZfua1FXc6eqgSrhaf5aLDUKXRh3463gesKjA=;
	b=jD9vsUihzYKoXWh1+BuDOk2WFzODPoWH2pCw7F97Dg4EKgOAJPYb8LDICLyUBxUUCnAc
	 SrmKYr3PH1VWl2Zo2PkO3jCF70D9xR98pOsxyec2RfcvO5MjP3VBs9cuxqGzYYwlKQ0ri
	 qzxyMmGPyzkLSbAOwDhLfvqlIpnho5ADmqmDVVIf9v4rmAwauGgJkku/0zN4VnKLyaTgb
	 QKlL6vCchJ8B6oqs2Q73+dk+JiZjd1vcnU72cI6jeMy9enq6tBiJIcyz99VLhYNbJFarM
	 7ySrzJP1xdkRQs/AvoEmr2Y3ckTEBupxn6MyLkZJQdKd15cCm1VVoOhfrcwsoYV6sEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JJ1Ep+IC;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D00606A329;
	Wed, 25 Nov 2026 13:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2D00606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JJ1Ep+IC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795613754; x=1827149754;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1e5Dk/+eHsZ1l5I1tk3VuGlTcyFCG8sOMZ/3BywUnEk=;
  b=JJ1Ep+ICGP7yZSo3Cg5sW7fFubadenZDM7NBad+7+6SF2SIgmO31qKaR
   RigINg780Drekf/O0Wn5+rj0PsCcMM7ERoNqFmrLppEK0wI/nc/5IXzXL
   A6i/pJMU93Qe9QiTq+iY9daa2n4aAGJ8S55ek3sAs59PtaXZq8gR0GSGh
   HbAh7XBfmcTKN25EZKoq5lbuovNyreshKqfx3ABUlxTt5osnhu/rV+DMx
   DaxN6oYPOyEy4+IoFnpqahwxgo99q0bg5nKfcaIdO8axk4+3NZhEVGeCo
   2B7/gLqSYQra925ZLvtnkOV4UkzDgNJTmWYQbUdOlMQNWJuOj6eYJgTVg
   w==;
X-CSE-ConnectionGUID: /y134ROzS7ipCKNHq2wRaQ==
X-CSE-MsgGUID: RhKuKuXKRgigPf+mJ48U4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4394731"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4394731"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 05:35:53 -0800
X-CSE-ConnectionGUID: EktULjI+TEyOqMp0HSpAaw==
X-CSE-MsgGUID: ViRb8WpMRBi9VV4ysbg3dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11678817"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 05:35:48 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 25 Nov 2026 15:35:44 +0200 (EET)
To: Priyank Rathod <rathodpriyank@google.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    Lukas Wunner <lukas@wunner.de>, Manivannan Sadhasivam <mani@kernel.org>, 
    Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
    Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
    linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/3] PCI/ASPM: Add internal pcie_aspm_inhibit()
 helper
In-Reply-To: <20261125-pcie-link-endpoints-v8-1-19d49c17c05f@google.com>
Message-ID: <115e024d-f49b-256f-550c-7a64b546a076@linux.intel.com>
References: <20261125-pcie-link-endpoints-v8-0-19d49c17c05f@google.com> <20261125-pcie-link-endpoints-v8-1-19d49c17c05f@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 25 Nov 2026, Priyank Rathod wrote:

> Internal PCIe services such as Lane Margining at the Receiver need to
> temporarily keep ASPM disabled on a link and restore its prior policy
> afterward without clobbering link->aspm_disable, link->aspm_default,
> L1 PM Substates, or Clock PM state.
> 
> pci_disable_link_state() permanently sets link->aspm_disable, and
> pci_enable_link_state() intentionally refuses to clear it.  Introduce a
> PCI-internal, reference-counted pcie_aspm_inhibit() helper:

As you've discovered, pci_disable_link_state() and pci_enable_link_state() 
are not symmetric pairs, which is problematic for some use cases like 
this one.

There's a series to fix that and to me it looks a prerequisite for this 
LMR series so you shouldn't be duplicate that effort with this inhibit 
thing.

Perhaps help in reviewing that ASPM series, and/or, if the work has 
stalled with things left to address, ask the previous submitter if you 
could take over in finishing that series.

> - Track temporary inhibitors via aspm_inhibit_cnt on struct pcie_link_state
>   under pci_bus_sem and aspm_lock.
> - Force state = 0 in pcie_config_aspm_link() whenever aspm_inhibit_cnt is
>   non-zero, so concurrent policy or sysfs changes still update the saved
>   state cleanly and take effect once all inhibitors release.
> - Return -EPERM rather than overriding firmware-enabled ASPM when the OS
>   lacks ASPM control, and return 0 when ASPM support is disabled.

Generally, don't describe things that are not real lists using bullet 
points (LLM tend to overuse bullets).

-- 
 i.

> 
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
> ---
>  drivers/pci/pci.h       |  6 +++++
>  drivers/pci/pcie/aspm.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 77efa4c5c960..e24a6dbf48ce 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1150,6 +1150,7 @@ void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>  void pci_configure_ltr(struct pci_dev *pdev);
>  void pci_bridge_reconfigure_ltr(struct pci_dev *pdev);
>  void pcie_encode_t_power_on(u32 t_power_on_us, u8 *scale, u8 *value);
> +int pcie_aspm_inhibit(struct pci_dev *pdev, bool inhibit);
>  #else
>  static inline void pcie_aspm_remove_cap(struct pci_dev *pdev, u32 lnkcap) { }
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
> @@ -1163,6 +1164,11 @@ static inline void pcie_encode_t_power_on(u32 t_power_on_us, u8 *scale, u8 *valu
>  	*scale = 0;
>  	*value = 0;
>  }
> +
> +static inline int pcie_aspm_inhibit(struct pci_dev *pdev, bool inhibit)
> +{
> +	return 0;
> +}
>  #endif
>  
>  #ifdef CONFIG_PCIE_ECRC
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index b039b57f8466..0d43dc517098 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -245,6 +245,8 @@ struct pcie_link_state {
>  	u32 clkpm_enabled:1;		/* Current Clock PM state */
>  	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
>  	u32 clkpm_disable:1;		/* Clock PM disabled */
> +
> +	unsigned int aspm_inhibit_cnt;	/* Reference count of inhibitors */
>  };
>  
>  static bool aspm_disabled, aspm_force;
> @@ -1055,6 +1057,10 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>  	/* Enable only the states that were not explicitly disabled */
>  	state &= (link->aspm_capable & ~link->aspm_disable);
>  
> +	/* Temporary inhibition overrides configured policy without mutating it */
> +	if (link->aspm_inhibit_cnt)
> +		state = 0;
> +
>  	/* Can't enable any substates if L1 is not enabled */
>  	if (!(state & PCIE_LINK_STATE_L1))
>  		state &= ~PCIE_LINK_STATE_L1SS;
> @@ -1538,6 +1544,70 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool locked
>  	return 0;
>  }
>  
> +/**
> + * pcie_aspm_inhibit - Temporarily inhibit or re-allow ASPM on a link
> + * @pdev: PCI device below the link (Downstream component of the link)
> + * @inhibit: True to inhibit ASPM, false to release the inhibition
> + *
> + * Maintain a reference count of temporary ASPM inhibitions on @pdev's
> + * upstream link without altering link->aspm_disable, link->aspm_default,
> + * or Clock PM state.  On the first inhibitor, ASPM is disabled in LNKCTL
> + * (Downstream component before Upstream component per PCIe r6.0 sec 7.5.3.7).
> + * When the last inhibitor releases, the configured ASPM policy is restored.
> + *
> + * Return: 0 on success, -EINVAL if @pdev has no ASPM link state or on an
> + * unbalanced release, -EBUSY on counter overflow, or -EPERM if the OS
> + * lacks ASPM control while firmware has ASPM enabled on the link.
> + */
> +int pcie_aspm_inhibit(struct pci_dev *pdev, bool inhibit)
> +{
> +	struct pcie_link_state *link;
> +	int ret = 0;
> +
> +	if (!pdev)
> +		return -EINVAL;
> +
> +	if (!aspm_support_enabled)
> +		return 0;
> +
> +	down_read(&pci_bus_sem);
> +	mutex_lock(&aspm_lock);
> +
> +	link = pcie_aspm_get_link(pdev);
> +	if (!link) {
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	if (inhibit) {
> +		if (aspm_disabled && link->aspm_enabled) {
> +			pci_warn_once(pdev,
> +				      "can't inhibit ASPM; OS doesn't have ASPM control\n");
> +			ret = -EPERM;
> +			goto unlock;
> +		}
> +		if (link->aspm_inhibit_cnt == UINT_MAX) {
> +			ret = -EBUSY;
> +			goto unlock;
> +		}
> +		if (++link->aspm_inhibit_cnt == 1)
> +			pcie_config_aspm_link(link, 0);
> +	} else {
> +		if (WARN_ON_ONCE(!link->aspm_inhibit_cnt)) {
> +			ret = -EINVAL;
> +			goto unlock;
> +		}
> +		if (--link->aspm_inhibit_cnt == 0 && !aspm_disabled)
> +			pcie_config_aspm_link(link, policy_to_aspm_state(link));
> +	}
> +
> +unlock:
> +	mutex_unlock(&aspm_lock);
> +	up_read(&pci_bus_sem);
> +
> +	return ret;
> +}
> +
>  int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
>  {
>  	lockdep_assert_held_read(&pci_bus_sem);
> 
> 
