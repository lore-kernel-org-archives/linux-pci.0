Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567066;
	b=rxO/gXOtWYPg6kR9z4vL+JDEql3Kay86A44OK0lUIW7Y71CocDfBsT+GCD9EbLOzqRnY
	 bcK8OeOnEuWRiBrNzDI0haRylf7ftU/IxqHxXYKhLDPQPJi5Ofg8i686I4Y3mLozT7vPY
	 yy9DkQPyNOyTEu28TZXOey7WcMmM1NL0Zru32qzN2ncXzvlbgeoBI33OdGkV7EhBX2dmq
	 Wvl0nM4t1uBp83b38rrVSN2KGcQnYvWE6j/hNQIwOFy6cDArhWza44iflCpiULsbYYEHC
	 PJFElBWT1/B+IgkRvWhjUBSsLdNQ5UAMW8/UpXqLYIcsOSzKWxcSc0r5AWxLISFyMcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567066;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Wna81KQd55XPz9SL1Rqr73OCs5czWxIC/NBaR9yfooA=;
	b=nVkJUtOn1DXrHceKTPmK9ifwF6oMaCwsa9He9SlGFxyzNSSWzn62m6x9mtxwigZ2lG/A
	 XSA5YQjBGE0AEn8vbWhogI7+8ESy2UItXJ4AiFcIApr4vWvUGh61XjmwNKnxqrjrJ0JvJ
	 JX80ZStFeQyLKQ253iaM/DAIfIWEirz7i0zwUyHjrSbQIOpPhicqtRwjk4mIBoihwzJqw
	 1RFCiGhYfz+dWIe/k0cjlBb6Fr7tc4FmkJlNcfeSJ3ndNuEfpcBU0KuiuLsK4QWLtPQfs
	 9SnGh5E12q1cgFxT/VnGSAz+yUoAWx9K+F5l+eHJvM3FoPNytgugTqT/3tLJ2xcX6pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kv7UHeda;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA8A606A31E;
	Wed, 25 Nov 2026 00:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kv7UHeda
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7231F000C0;
	Wed, 25 Nov 2026 00:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795567065;
	bh=Wna81KQd55XPz9SL1Rqr73OCs5czWxIC/NBaR9yfooA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=kv7UHedaWnXjIMjYX3C4Ps1IpPnWbHz4Z/As33aiLXOvTkkaaoeb6vCrcxkv2yU+u
	 yztC7iVguk8T37lU9rIraBRqGAuA89vAIsA3rSIEFgc//YCGBxYOmi2TJ39FgHmRLh
	 hBtOal8oWYMslNtoEWyUcEi2feklf0XDF7mbsgwFKephXiuMz/a1X6fl1Pq3cI4Mv3
	 441qxvmWExDGu2FBodXjN4+PycV7LgX462BJzaS08O4C8bBMInVrpkL0Piq1jlW5Mm
	 8ft79FfWC5F539NfoeZGRhw3rUkQ7oYMsJSOd8oee3LhKXDD4pfOLH/a8XK2tWFVae
	 1FtrTQ2e2hQxQ==
Date: Tue, 24 Nov 2026 18:37:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Priyank Rathod <rathodpriyank@google.com>
Cc: bhelgaas@google.com, lukas@wunner.de,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilpo.jarvinen@linux.intel.com, dave.jiang@intel.com,
	prarit@redhat.com, ying.huang@linux.alibaba.com,
	terry.bowman@amd.com, corbet@lwn.net, jic23@kernel.org,
	danielmaraboo@gmail.com, linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/AER: Make aer_mask_override effective for
 injected errors
Message-ID: <20261125003744.GA1202129@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028173038.292999-1-rathodpriyank@google.com>

On Wed, Oct 28, 2026 at 05:30:38PM +0000, Priyank Rathod wrote:
> Hi Bjorn,
> 
> Thank you for reviewing the patch!
> 
> On Tue, Oct 27, 2026 at 06:08:53PM -0500, Bjorn Helgaas wrote:
> > Can you start with a one- or two-sentence description of what's going
> > on here?  Evidently injecting some errors doesn't work as expected
> > today?  As long as the justification is compelling and the code is
> > readable, I don't think we need quite as much detail about every
> > little implementation detail.
> 
> Good point, thank you.  Would a shorter commit log like the following
> look better to you?
> 
>   aer_mask_override=1 is supposed to allow injecting masked errors, but
>   aer_inject() corrupts the hardware Mask registers with "&= !" and
>   restores them before irq_inject_interrupt(), so aer_isr() still drops
>   the error as masked.  Emulate aer_mask_override in config space reads
>   and writes instead of modifying the hardware Mask registers, and
>   document the parameter with MODULE_PARM_DESC().
> 
> I am happy to send a v2 with this updated commit message, unless you
> prefer to adjust it directly when applying.

Mixing the logical "!" with the bitwise "&=" in
"cor_mask &= !(einj->cor_status)" definitely looks bogus.

Please post a v2 with updated commit message.  Better to minimize
change between what you post and what gets applied.
