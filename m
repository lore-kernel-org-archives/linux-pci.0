Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14E8496D48
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303085; cv=none; b=lCOKpKMXgb0Oyxv6nDlcqwDKmM+RuUJWsYMuhSBlFTMjvVhmv34EATDdBKQUxmJajvavXHxOYZgnfklI3HghWzfJOVpwdQa7j8YBG7Jny6FW87UWqFImiwCA2DZY+5d3/bAZ70Tvr1E1WXB2IQJVs9VUgSfiSTh4If5MtSp8wOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303085; c=relaxed/simple;
	bh=YBZe+C652Mt5wiOMYN6vWBMlwUCAKX2q0sKMcb9Ax9Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y+s9hq0BipVEvH+SnucmXUgVVzqXWFrmzeQtpmvP+yYMY/e6i8XTA7VWxEzSADn4RgvEDHnNVhRWmVL8HmhbpHUhpyTeTqeNjWIPOw9GBIKbi+C6sW+UgU7+pTXVIdL8AwgwhcAhaLaDwdwaCWHQ4+qWhruzKbR7nIe3/BIrU6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FsYspK57; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FsYspK57"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e2d3a3ff86so44571785ad.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2026 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791303083; x=1791907883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F7fiIy44pA40Qzblb6RujesfpZqXOXl3zixxZTEALtM=;
        b=FsYspK57tzzrJJC4RirtYlchoJ8fPye1U2yVXrz2a88Dnj6hC0lfThCZNTOODnDpS6
         oyuIT/soZb8RI/9OTio9fHmMW4N/1Z2sLjOxga+iA2k7HmhhseWKyOHKCqhhECQEBtA2
         EXqSduwuqE3wW/+PKDuw2NJLvtZbwkraZMNOD1PU8Q+tPbpAIWzjkmY0zds8GVMW4+bC
         jDPz/1lrL50anR/odDOJ97LlrVQEtvoerYIElZSjyZvsx/YcjyRK0QBY6BbUHLoYuwy9
         zeeecb735TGZQHNjy/yz/0OgQII2kvs5VXMW6sqvj9KkxZoGxxzdGwYzdwyWL9VzInfJ
         I9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791303083; x=1791907883;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F7fiIy44pA40Qzblb6RujesfpZqXOXl3zixxZTEALtM=;
        b=KhSU6xOGgtiKVJ5I/czOY7L+IH3+9zml4xzqwAzTCcZ+U2fb/qni5Q/eHjg0Yqja7K
         rvAXFQZvIZbVzWPbMO0Mau10I9tqy7NtuI6Tfi6484c6sC24/dRj4gNmEv8yFIywr4Si
         QmJadjwF2pTRKyuS7MEDYZPohAwL3lul5yXjZY9Lyp3bQ/7bT0TeioWGM41Favd8QSGo
         mogJ26ZchWY6J1ONX8sdavMrAG5swi1rtnaBxpvcfnMeq+lBGD0vu38rFEMxc19RaLli
         E6x+LyK5zNp+1DLIFu9aLJSSWasI/kDdHnv4wyKJudi+mdmLsdGaJ/Zoc25nDJoBzTr+
         wMxA==
X-Forwarded-Encrypted: i=1; AKwUvBwLYFNmUzNYeLHsxsVlJQmDFi9Kx5CIRTTkAFxIW/gwen6xFwMuHhN9Sh/XVsLjYbFee1pmHRYjfp4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNnRjxZQ1S8ilZa+RANWKXDvRukIlnKHdZRGuH1pIMxUNjxnaU
	Ql1X2NM+imBTz5G0L+3J6cl35bMcFvQj/CH9W0WFj7FnEp294AMCNp5ll1lArSQMJC2OVmcGW9e
	NANRFyq3hnO/6F0aQw5ObNa/XdHvt3fAo5g==
X-Received: from pltf6.prod.google.com ([2002:a17:902:74c6:b0:2e5:c07f:b4c2])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:41c8:b0:2db:3b35:1ac6 with SMTP id d9443c01a7336-2e5dccf67aamr16741525ad.5.1791303082968;
 Tue, 06 Oct 2026 09:11:22 -0700 (PDT)
Date: Tue,  6 Oct 2026 16:11:22 +0000
In-Reply-To: <03f0fedb-beeb-369a-47dc-e7ddc3b27aef@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831-pcie-link-endpoints-v1-1-32c2fd893e9e@google.com> <03f0fedb-beeb-369a-47dc-e7ddc3b27aef@linux.intel.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006161122.921339-1-rathodpriyank@google.com>
Subject: Re: [PATCH] PCI: Add pcie_get_link_endpoints() helper
From: Priyank Rathod <rathodpriyank@google.com>
To: "=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Sep 2026, Ilpo J=C3=A4rvinen wrote:
> On Mon, 31 Aug 2026, Priyank Rathod wrote:
>
> >   - ASPM (drivers/pci/pcie/aspm.c): pcie_aspm_get_link(),
> >     alloc_pcie_link_state(), and pci_configure_ltr() resolve parent
> >     bridges and subordinate function 0.
>
> This is not the full picture. The aspm driver has to write the same confi=
g
> to all functions (except L1SS that is only in func 0).

Hi Ilpo,

Sorry for the slow reply, and for posting LMR v3 before answering this.

You're right. The helper only returns Function 0, which isn't what the
ASPM driver needs, so I shouldn't have listed it as a user.

> >   - Precision Time Measurement (drivers/pci/pcie/ptm.c):
> >     pci_upstream_ptm() traverses pci_upstream_bridge() to validate
> >     upstream link partner capabilities.
>
> This looks something entirely different, and it's pure get (a certain)
> device upstream, not the get-my-link-partner query.

Agreed, PTM comes off the list.

> >   - PCIe Link Retrain (drivers/pci/pci.c): pcie_retrain_link() and
> >     pcie_update_link_speed() coordinate link retraining from the
> >     Downstream Port across the subordinate bus.
>
> I don't entirely agree with this assessment. pcie_retrain_link() is given
> a downstream port, mere looking into ->subordinate doesn't constitute as =
a
> need for having access to the struct of the other end of the link.

Agreed, that one goes too.

> >   - AER/DPC Recovery (drivers/pci/pcie/err.c): pcie_do_recovery()
> >     identifies the parent bridge via pci_upstream_bridge() to trigger
> >     secondary bus reset and broadcast driver recovery callbacks.
>
> This seems to have some validity, though it must cover RCiEPs.

The helper doesn't handle RCiEPs, and I don't have a patch converting
err.c, so I'll drop it as well.

That leaves LMR as the only user, so for v4 I dropped the exported
helper and kept the lookup private to margin.c. LMR only needs
Function 0 on the Upstream Port side (pcilmr makes the same
assumption).

On v7 you said you'd like to avoid duplicating what the ASPM driver
does. If you'd rather have a shared helper in the PCI core, I can do
that as a separate series that also converts aspm.c, so it has a
second user from the start. Let me know which you prefer.

> > +		*upstream_port =3D pdev->subordinate ?
> > +			pci_dev_get(list_first_entry_or_null(&pdev->subordinate->devices,
> > +							     struct pci_dev, bus_list)) : NULL;
>
> Too much is crammed into one statement.
>
> > +	} else {
> > +		*downstream_port =3D pci_upstream_bridge(pdev);
> > +		*upstream_port =3D pdev;
>
> Why complicate things with the unbalance?

Both were fixed in the copy in LMR v3 (patch 1/3), which takes a
reference on both ends. This code goes away in v4 anyway.

On ASPM, since you asked about it on v6 and v7: v4 drops
pci_aspm_inhibit() and doesn't change aspm.c. It uses the existing
API the way ath10k, ath11k and ath12k do: save with
pcie_aspm_enabled(), call pci_disable_link_state() before margining
and pci_force_enable_link_state() afterwards. Reading aspm.c, that
round trip doesn't restore everything, so v4 adds a few things in
margin.c:

 - If pcie_aspm_enabled() returns 0 (firmware left ASPM off,
   pcie_aspm=3Doff, or the "performance" policy), v4 calls neither
   function.
 - It disables only the states pcie_aspm_enabled() reported, not
   PCIE_LINK_STATE_ASPM_ALL, so the restore clears the same
   aspm_disable bits (except the L1 substates, see below).
 - __pci_enable_link_state() sets clkpm_default from
   PCIE_LINK_STATE_CLKPM, which pcie_aspm_enabled() never reports, so
   with the default policy the restore would turn Clock PM off. v4
   adds PCIE_LINK_STATE_CLKPM to the restore mask if CLKREQ_EN was
   set at the start. The ath drivers hit this too.
 - It reads ASPM Control in Link Control on both ends (read-only) at
   the start and before each margining command, and fails with -EBUSY
   if it's set. That covers firmware-enabled ASPM with pcie_aspm=3Doff,
   and ASPM coming back on mid-session through the link/*_aspm sysfs
   files or another driver calling pci_force_enable_link_state().

The rest is documented in pcie-lmr.rst:

 - If another driver disables a state that LMR also disabled, the
   restore turns it back on.
 - aspm_default ends up as the saved set.
 - Disabling L1 also disables the L1 substates, so substates that
   were off at the start stay disabled.
 - Without OS control of ASPM, the disable works but the restore
   returns -EPERM, so ASPM stays off until reboot.

Counting disables per state in aspm.c, as you suggested on v7, would
fix most of these, but v4 doesn't depend on it.

v3 also brought back the MSampleMultipleReceivers bit that you couldn't
find in r7.0 on v5. That was my mistake, and v4 removes it. Some
section numbers in v3 were wrong too (Link Control 2, for one), so v4
refers to registers and fields by name instead of section numbers, and
keeps comments within 80 columns.

Thanks,
Priyank
