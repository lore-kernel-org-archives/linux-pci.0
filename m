Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109002;
	b=ioe9cGuyHQOxWT/5ncIJqgBtoE+8JtFt8moLuS2a90oVSlmx1w+JKkYYXFX/XUjFP8TN
	 Kq5aemc2yG0oLaydjoI6ghogLggngTygQKC3y+g9/U6fI8lYG/btWLjoOyRBDxX3L5//Z
	 GdR1jit3WDW4cFr/ULtwVms2j+/PmZlpAbNe96gZm93y03OZUUZOa7ejzjBOlk5DZJJcW
	 P+3NXJEOzsC0EihS2BS6p3fbK3iiVllM0RCJ7E/SMLS8L1k2NFrZhoHfhMO017nz23wJS
	 UNM9mThRCTS4eWAMwGy6OQzM+gy7LGTjXnidPgC0DlTT5+zhBekAas9Ac0MY6caX9IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109002;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=oG15c41ZCpZQNvxF6sTCZaD3NnnBG9uH9Ql0/dc+j8c=;
	b=AAxdZmkZ3IRYbJv1m1THQ/+0A5wQJJMz5QHLdLEodaNpKo1wzMb8dk/swYeCFy+It1hA
	 jkqJrCmK2ZpnS8stpgQ4OMzwAxMXnSQaALwN4Cm5jZf7Q3sBgdn9f+Xd4hKsF7ncVd/oa
	 SPk3F7rCJe2psQ08w61RUxRwilGDCJ3Fh3cVXPbkFXtMw4fCfPBtkhFfiXa2t0TZ6xIoa
	 3ZOTncTOaE1SNXSo+U8vxkijkbF+LiG3dDl4M9o2VGEISlvbEmsYL7rdvNNikYvlc9P81
	 qH/7j1y4i67NhKy46CwPwyEQA8V0Zg7YaLNB8O9ryhmQd1Otwzft6PwK+R942lN1NyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RjDs61XI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3020C606A33F;
	Thu, 19 Nov 2026 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RjDs61XI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1591F000CD;
	Thu, 19 Nov 2026 17:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795109001;
	bh=oG15c41ZCpZQNvxF6sTCZaD3NnnBG9uH9Ql0/dc+j8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=RjDs61XIgonkH9vpbrzUGLyj7OEgV93wQ8sNJNIkNmHJX72C7dMHidRR8ZtvFTGVY
	 OHhvrqF3jft4IBlmwc1dD6OQeG9BLW/1457VsJdjCHVn/fwl1IgQ26tUaNIqpcQ7Qr
	 okPp7AMoPlEqxo1CaxEOmoiHUwfCLTl4X1Q7way7djNyIwZcPORyWPkG4GFDsx3T/8
	 CCzDgr7bpQ8AcSyPMneLUpmPZ+pF08RBuBUAI2Vei1ySKZNKSO7Sr7exEGFDj4pF/t
	 kGgQSfKvdWL89pQHrfX45+RxB5hDhpUpa3SMSavd/K+AQ9lrw+/vjjZSs/oX2m/qVI
	 d2y/6vSVxEaWA==
Date: Thu, 19 Nov 2026 11:23:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Habil Eren =?utf-8?Q?T=C3=BCrker?= <habilerenturker@hotmail.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"tglx@kernel.org" <tglx@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 1/4] PCI: Add pci_power_t helper functions
Message-ID: <20261119172320.GA817954@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29fcfa729d7f687f66578781c2e23db9e3367c86.1795097970.git.habilerenturker@hotmail.com>

On Thu, Nov 19, 2026 at 02:35:46PM +0000, Habil Eren Türker wrote:
> Add helper functions to extract, set and compare PCI power
> states in the Power Management Control/Status register.
> 
> This follows the discussion with Andy Shevchenko and
> Bjorn Helgaas in response to:
> 
> "[PATCH] x86/quirks: Cast PCI_D0 to u16 in apple_airport_reset()"
> https://lore.kernel.org/lkml/20261118161559.63617-1-habilerenturker@hotmail.com/

Andy had good comments about the style of references like this, but
IMO if your cover letter includes links to previous versions of the
series, that's enough of a breadcrumb, and previous review comments
and suggestions don't need to be explicitly called out.

https://lore.kernel.org/all/20261112-vfct-regression-v7-0-69b1e0cf45c2@amd.com
is a good example of the previous version link documentation in the
cover letter.

> @@ -2953,4 +2954,31 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
>  	WARN_ONCE(condition, "%s %s: " fmt, \
>  		  dev_driver_string(&(pdev)->dev), pci_name(pdev), ##arg)
>  
> +/* Helper functions for PCI power management */

I think these should go right next to the pci_power_t definitions,
e.g., right after pci_power_name(), so they are easy to find when
using PCI_D0 etc.

> +static inline pci_power_t pci_power_t_get(u32 csr)
> +{
> +	return (pci_power_t __force)FIELD_GET(PCI_PM_CTRL_STATE_MASK, csr);
> +}
> +
> +static inline void pci_power_t_set(u16 *csr, pci_power_t state)
> +{
> +	*csr &= ~PCI_PM_CTRL_STATE_MASK;
> +	*csr |= FIELD_PREP(PCI_PM_CTRL_STATE_MASK, (__force u32)state);

FIELD_MODIFY().

> +}
> +
> +static inline bool pci_power_eq(u32 csr, pci_power_t state)
> +{
> +	return pci_power_t_get(csr) == state;
> +}
> +
> +static inline bool pci_power_gt(u32 csr, pci_power_t state)
> +{
> +	return pci_power_t_get(csr) > state;

I'm not a __bitwise expert, but I'm surprised this works.  I expected
that __bitwise values would not be ordered, so only testing for
equality would be legit.

I do think these should take two pci_power_t values instead of a PMCSR
value and a pci_power_t.  The extra internal conversion on one
argument feels a little bit non-intuitive.

> +}
> +
> +static inline bool pci_power_lt(u32 csr, pci_power_t state)
> +{
> +	return pci_power_t_get(csr) < state;
> +}
> +
>  #endif /* LINUX_PCI_H */
> -- 
> 2.47.3
> 
