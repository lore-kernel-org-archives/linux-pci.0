Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9111C3BB113;
	Tue,  8 Sep 2026 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901314; cv=none; b=pbFwTi99ScZcnyS82dlfdWF9X+pAEUeQBe1En8wkCrk/RbZbj5QaDn8/TcSW3SJNvqqgJbcKHUr/C1fd3GL0JEe0T3ieOFnSGdH8zzFBv5EJ2u1cLiN37+toO7b+o3SFD8XAl6d3OXj2w9BUeMwnqV53J4LpLPSey4su9C+910g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901314; c=relaxed/simple;
	bh=R88BU113Ov2GVW3CCef5ODw9mJyxw0AUbcvsOjZILpg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rqvX+oRw/fgDoY7E1jEItB7Z+S0eulL2VgUB32AB6+n8PQVYUzZcKujWrZXhGgWtn1RbJkaKR1X40ZbWatVX5vvvgjMwEXoNOutA26Dk4NdUpRnoe/fSLgEJ/OjVD23SmFCwlDY9DffQhCLSdG+43PIzspAutGcP/Mv2JXBb/mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=KFydSysn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iqo4qWzN; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="KFydSysn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iqo4qWzN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D3AD81D000D4;
	Tue,  8 Sep 2026 17:01:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 08 Sep 2026 17:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788901303;
	 x=1788987703; bh=Ak4aXn/J9UFNps7xywOGNcr1ellYBnqo9Nq2S017ioE=; b=
	KFydSysnTaOK+qWkUcxB+5q0fKleBKzILDe4OSJ/0qbFauVftLH6WcGS5sl9G5Rx
	rHrhBdU2abnJOmm0oft+ddPgSfP+UofOi0CHxbsLToddSQR3B4uRLShlg0mRO/I/
	FMMZQW/zo7+q06SbtOTM4ZeHqPOFXLqK42hbDeq7UVmoZsQ6FpHfaz1oHiPEokUM
	3mrWtTCEB1qgtrfmsRu54RWxgZKpqRCmWj7/8giEAQ18JUOEet/Xz4ePhUaygZAl
	0FYVg78jJcu0/O03oyVp9fdwdzw8TEgFtJN8DCoHByLGkL7G2KtWThb10NYCO5z/
	yqwgJo9CKzKRH9DPxZaB4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788901303; x=
	1788987703; bh=Ak4aXn/J9UFNps7xywOGNcr1ellYBnqo9Nq2S017ioE=; b=I
	qo4qWzN/+Lok/fPYJO/bAEq4QkYIg6+Dc4Y5AzMtRzXtcShIy0xMe0PbYecW8hEz
	1oepgMSs8ZA/y2/HCG1DjlQhyWNMdo7DY7SPL87i47ZYWAc/EfoBQEhBrZWsptLA
	1OopTRKEToOM6dX2S82pLqmR1e0u6mdvQnJJHLepgR4SaUJiOMMh0DOdJn9KjRsi
	zzeV6qJTHn2Yl5eJ2znjrVkC+CYP24ZvM3dq12BXjF8h70VYWhnEZrNFdAYGLBmo
	3YwR8YuRrs/zKNldrTJTpctybAGndpNFzGGQORs/goy4JqgGMxGRBU4ZlLzxpKVb
	9ripmBb/cmsHOHLY3HqqQ==
X-ME-Sender: <xms:t3egakx6LgomlJqvEB-5Z6dW5XVNk2pcuoRrZv51aXlqgp4GNBaTAg>
    <xme:t3egalMYR1EQCJADzmHjaQKPTihJi8bDeaUJ-iSyOcTX6yr1Uk9-ZVqRNG7moP6lO
    LUpZaVtlO_rO-Hmn5_W0TabYAX0jOKLOg_-aRckuySUdMcMiNucHJgh>
X-ME-Received: <xmr:t3egah8LjVaEsTfoV5lYRu83DBlE6Q5V2Ekannvvvw83N1GtmSaYZIORjII2Rw>
X-ME-Proxy-Cause: dmFkZTFIH8iit+sxAjNODbCXEvypWI25uNXksiMrqjSrNoYPbeZ2nS/CYn2xAhwq9q5dED
    vUaiSEJtuLNF8PJIgokv5KsZj76F1WDmH6hEDI8SbsQhLEdJ65I6jwSoG+Ewvg/hUGrIgY
    RxXLpw4XsFOtYcqqzwVLeY+8rtbmlxtvhwxnnJnTZZAdrPxEtEJOmbaK0ktc5U3IepKDiK
    4zaW8zjewzc2tGAdpDykgn44XAsaT3p0uTcBgwV14rLV8JzNU3rYMWpzQzghIn1AcWRsMa
    MZVvWS6goHVpVObPevvAkOTQsfOliqyqM1+o2coAi9hg3xNlD6xzn3E6Qdh2VU0+BXlrm+
    Ub0RBgfwsN0Is2b+SAhtoswLpc1gcy0GX3ZO0sAOfVaOcMoQwEi7wQNqHy8d8Ak78n0Pq1
    TBzypWq5oN9yex3xbdobGbJ+SlRB0jyskqjg83c2pcetDuYzLk5IoEBFfPRvcN+bCw055S
    Uu0ICk70dMGfusGz8QkKmaUqz87fiq0y7D3s7ItQhTfSM5LshCaRtZ/1JFur1i0mm6DlDA
    fKhAnKZN+6hZ245GhfWuWvIPHrmMaIPP0HEVBu12Q836SpueqYshCWT14jVq1FtFRVHUsK
    aH7fj74Ngqc00Qyt+RCUsgTj4oXP7NuT0jUljMNDPfqwc9pXJZelgcCDfXZQ
X-ME-Proxy: <xmx:t3egaq4k3twHEoeJsKzLntV8jbu-KJDD3Qc3tpatIZpEHJpZ6uMQaw>
    <xmx:t3egav7vqTT6zoArr19B0iSEcPZWCZBqA0zxD3twtI0po-5vt1VIOg>
    <xmx:t3egarqz5B64wChDuc2tOyXQTQRnnCv67e8MrjutkE8NN-Xtpnwk4g>
    <xmx:t3egaoOCBc_euIRB4XZ_H5Y0FyI2X0HJhNQ72Pn3CtpOxZthfoZdYQ>
    <xmx:t3egakS-UrHy46ruI2V679t5X9vn_EiVc26hKIu65rvs9hauVt4WFHI6>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 17:01:42 -0400 (EDT)
Date: Tue, 8 Sep 2026 15:01:40 -0600
From: Alex Williamson <alex@shazbot.org>
To: "Engel, Amit" <Amit.Engel@Dell.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Farhan Ali <alifm@linux.ibm.com>,
 alex@shazbot.org
Subject: Re: [BUG/RFC] PCI/EDR/DPC: vfio-pci endpoint left disabled after
 successful recovery
Message-ID: <20260908150140.4f5ead2b@shazbot.org>
In-Reply-To: <CO1PR19MB48858DF4BB793A09ABEA7E1DEEB32@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <CO1PR19MB48858DF4BB793A09ABEA7E1DEEB32@CO1PR19MB4885.namprd19.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 6 Sep 2026 18:34:02 +0000
"Engel, Amit" <Amit.Engel@Dell.com> wrote:

> Hello,
> 
> I am investigating a firmware-first PCIe DPC/EDR recovery issue involving an NVMe endpoint bound to vfio-pci.
> Linux reports that DPC recovery completed successfully and sends EDR _OST status 0x80 to firmware.
> However, the downstream endpoint's PCI configuration is not restored: PCI_COMMAND remains 0x0000, Memory Space Enable is disabled, and the device cannot accept MMIO accesses.
> A manual Secondary Bus Reset later causes hot-remove/re-enumeration and restores the endpoint.
> Environment:
> Platform: Dell PowerEdge, firmware-first DPC/EDR
> Kernel: 6.4.0-150600.23.92-default, SUSE Linux Enterprise 15
> Endpoint: 0000:07:00.0, KIOXIA NVMe
> Endpoint driver: vfio-pci
> DPC downstream port: 0000:04:04.0
> EDR notification Root Port: 0000:00:01.1
> 
> Reproduction:
> 1. Start IO
> 2. Confirm the endpoint's initial PCI Command register:
> setpci -s 0000:07:00.0 COMMAND
> 0406
> 3. Clear the Memory Space Enable bit:
> setpci -s 0000:07:00.0 COMMAND=0000:0002
> With IO active, a component attempts to access the disabled MMIO BAR. This results in an ERR_NONFATAL event and DPC containment.
> Observed EDR/DPC recovery
> The kernel reports:
> pcieport 0000:00:01.1: EDR: EDR event received
> pcieport 0000:00:01.1: EDR: Reported EDR dev: 0000:04:04.0
> pcieport 0000:04:04.0: DPC: containment event, status:0x2003, ERR_NONFATAL received from 0000:07:00.0
> pcieport 0000:04:04.0: pciehp: Slot(167): Link Down/Up ignored (recovered by DPC)
> pcieport 0000:04:04.0: AER: device recovery successful
> pcieport 0000:04:04.0: EDR: DPC port successfully recovered
> pcieport 0000:00:01.1: EDR: Status for 0000:04:04.0: 0x80
> 
> DPC Trigger Status was cleared,
> Therefore, the link-level DPC recovery appears to have succeeded.
> The endpoint remains present in PCI enumeration and sysfs and is still bound to vfio-pci. However:
> # setpci -s 0000:07:00.0 COMMAND
> 0000
> lspci reports:
> Control: I/O- Mem- BusMaster-
> Region 0: Memory at ef000000 [disabled]
> Kernel driver in use: vfio-pci
> The endpoint cannot accept MMIO operations in this state.
> 
> Later, I manually issued an SBR on 0000:04:04.0. This caused pciehp removal and re-enumeration:
> pcieport 0000:04:04.0: pciehp: Slot(167): Link Down
> vfio-pci 0000:07:00.0: Relaying device request to user
> vfio-pci 0000:07:00.0: vfio_bar_restore: reset recovery - restoring BARs
> ...
> pcieport 0000:04:04.0: pciehp: Slot(167): Link Up
> pci 0000:07:00.0: BAR 0: assigned [mem 0xef000000-0xef00ffff 64bit]
> vfio-pci 0000:07:00.0: enabling device
> 
> After re-enumeration, PCI_COMMAND and MMIO access were restored.
> 
> This seems related to:
> [PATCH v18 3/4] vfio/pci: Add a reset_done callback for vfio-pci driver
> https://lore.kernel.org/all/20260603182415.2324-4-alifm@linux.ibm.com/
> That patch restored VFIO's initial saved PCI state using:
> pci_load_saved_state(pdev, vdev->pci_saved_state);
> pci_restore_state(pdev);
> 
> This is conceptually similar to what appears to be missing in this reproduction.
> However, reset_done() appears to be associated with PCI function-reset operations. The EDR/DPC path uses dpc_reset_link() through pcie_do_recovery(), so I do not believe the proposed reset_done callback would be invoked for this case.
> I also did not see the generic VFIO reset_done patch in the later v19/v20 VFIO series. Was it intentionally dropped?
> 
> Questions
> 1. Is it expected that DPC link recovery succeeded but no endpoint driver callback confirmed that the PCI function was restored?
> 2. Should vfio-pci implement slot_reset(), or another post-DPC callback, that reloads vdev->pci_saved_state after the link becomes accessible?
> 3. Alternatively, should the PCI recovery core restore generic PCI configuration state for downstream devices before reporting recovery success?
> 4. If the endpoint's PCI state cannot be restored, should EDR return a failure status instead of sending _OST 0x80?
> 
> Before reporting successful recovery, I would expect the kernel/VFIO layer either to:
> * restore a safe PCI handoff state, including BAR configuration and
> Memory Space Enable; Bus Master Enable may remain disabled until userspace reinitializes DMA, or
> * report that recovery failed.
> 
> Leaving the endpoint enumerated and bound to vfio-pci with PCI_COMMAND=0x0000, while reporting successful recovery, appears to be a false-success condition.
> 
> Please let me know whether this behavior is already known or whether the expected fix belongs in vfio-pci?

Known behavior, vfio-pci has never supported recovery from an
uncorrected error.  Such an event triggers the error eventfd to signal
the error to userspace, but does not provide any means for userspace to
participate or observe the error recovery.  The typical VM behavior is
a VM_STOP on such error.

There are efforts[1] in motion to improve this, which you're welcome to
contribute to, but the userspace driver plays a part in any uncorrected
error event, this isn't simply a matter of restoring the command
register and continuing.  Thanks,

Alex

[1]https://lore.kernel.org/all/20260901093217.8539-1-skolothumtho@nvidia.com/
