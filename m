Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795677066;
	b=tq0kCb56CGnxmvAaZVs0ALl5Ex6tdNcp83hfbi5iZxyNwfxNJDL4rG2G0W/eyR1On1Re
	 ha77nx2rjBjKRBstmEiZ7I+QrLxQ6PzjI1pGRtdQS5tu6jbB13cTtefH0CBjJ2TjvSMw9
	 HLapsDfNT+sF7g87Eu8vIL6JmP77amm7BO0rGH6JpFpC2cAU1sZJDGgGan/Qh7Iv9zmjK
	 F2LCJ/0bCjbqhFkkLeiUHsNSqfIfJ0Aa5PCv30kbKSeUHVUOv6iKVxqmD1xO4sQ53ftEz
	 dysoOlS2clbr88qMii6m1DKEJwKFQY05hvOsew+GLO4Fh/e+OJ3sZOr1CLdO4qoeO2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795677066;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6ONmqsNqsZdNsXiXsEEFMKR8dsVCP1TSyGx3SqfTDHM=;
	b=H9+50MCaritlW4ITW5KRu8gtbb7B6XWj5h2hXNPxfd5LZ0kacEAnWsNqis+yCOcmLCRu
	 FsQYN/yP5Xc/PXZFPFLtZia6PRdX9wewtxluCRw1rX0RrzMDut8Raz5T4hxFIzIU8EKMz
	 shJLhLNzJ9oR5Ofl0UMqaC61lWeJZ2C9tARFFu2wYbHqd6oebb39+745nKKPmkb6Cw7wV
	 DbzbGxhezvnMJNWCcy1pFT/E0YG1EELnITs1ncSngNC+RjD8GCnkbDpwYSOfyvHJ69dch
	 Agf6NELQ4u1FXpuj4PKjd2M5o1oSCBZ7KaElf5Ejdo7+Cg0HG8fpEs1vYeCpJSQdSgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X9X8YwmW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B02A606A31E
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X9X8YwmW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621B81F000C6;
	Thu, 26 Nov 2026 07:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795677065;
	bh=6ONmqsNqsZdNsXiXsEEFMKR8dsVCP1TSyGx3SqfTDHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X9X8YwmWNCLZxQILVBhbrgIUzK7CNW2A9Q4EJKWLbyAsxLLfZvzGHVBkDXkBLiFZm
	 yXFeM+GbXJHHNvNmqQwsd+I+cbydjCQJ2JmvnRzctw07BraXe5E3trl+3BGldvzBJ/
	 WLWmJSy0zkSHbv6UmzN6w4Gpu5R9MCxuuf/5w4QVMnuBzfYIfnp5pg2YH/txfAacv2
	 5dzUkQYdyFWktxQ3F17kPM56XLBEBuFFZWcOdZEjxqYfrD6ifRmGVYIOeLdofrN5n/
	 rJo278L6KmbX14KU9/OcdqRHxaGT1h+CWtkEalnRyA+hFykUSf4eniZ1r02467z4g3
	 dojACva0EV+Bg==
Message-ID: <sashiko-outbox-234935@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/MSI: Retry a mismatched MSI-X message once during
 restore
Reply-To: sashiko-reviews@lists.linux.dev
To: raoxu <raoxu@uniontech.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <4EDB2ADA2CFC5963+20261126064901.1798104-1-raoxu@uniontech.com>
References: <4EDB2ADA2CFC5963+20261126064901.1798104-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 07:11:05 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] PCI/MSI: __pci_restore_msix_state() reads MSI-X table when
  channel is frozen
- [Medium] PCI/MSI: unreliable retry and offline read in
  __pci_restore_msix_state()
--

commit a9578a3be66676c84a41222ba8afbb2d8beac990
Author: Xu Rao <raoxu@uniontech.com>

PCI/MSI: Retry a mismatched MSI-X message once during restore

This commit reads back each MSI-X table entry in __pci_restore_msix_state()
after writing it and retries __pci_write_msi_msg() once if the readback
differs from the cached message.

> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 4e8ec8d42aa6b..4ab2c670a2d40 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -870,6 +870,7 @@ int __pci_enable_msix_range(struct pci_dev *dev, stru=
ct msix_entry *entries, int
>  void __pci_restore_msix_state(struct pci_dev *dev)
>  {
>  	struct msi_desc *entry;
> +	struct msi_msg actual;
>  	bool write_msg;
>  	u16 cmd;
> =20
> @@ -895,6 +896,15 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>  		msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
>  			if (write_msg)
>  				__pci_write_msi_msg(entry, &entry->msg);
> +			if (write_msg && dev->current_state =3D=3D PCI_D0 &&
> +			    !pci_dev_is_disconnected(dev) &&
> +			    !entry->pci.msi_attrib.is_virtual) {
> +				__pci_read_msi_msg(entry, &actual);

[Severity: Medium]
Should this guard check !pci_channel_offline(dev) instead of
!pci_dev_is_disconnected(dev)?

Both __pci_write_msi_msg() and pci_msix_write_vector_ctrl() skip MSI-X
table MMIO accesses when pci_channel_offline(dev) is true, as updated in
2e2f69fc8ae2 ("PCI/MSI: Skip MSI/MSI-X programming while the channel is
offline").  pci_dev_is_disconnected() only checks for
pci_channel_io_perm_failure, so if __pci_restore_msix_state() runs while
dev->error_state is pci_channel_io_frozen, __pci_read_msi_msg() still
issues three MMIO reads to the unreachable MSI-X table BAR.  When a
Downstream Port link is contained by DPC, those reads complete with
Unsupported Request (returning 0xffffffff), which can trigger an RP PIO
error and secondary Root Port containment on Root Ports with DPC RP
Extensions, as well as a duplicate __pci_write_msi_msg() call.

> +				if (actual.address_lo !=3D entry->msg.address_lo ||
> +				    actual.address_hi !=3D entry->msg.address_hi ||
> +				    actual.data !=3D entry->msg.data)
> +					__pci_write_msi_msg(entry, &entry->msg);
> +			}

[Severity: Medium]
Can an immediate single __pci_write_msi_msg() retry still fail when the
device is not yet responding to MSI-X BAR MMIO accesses?

pci_write_msg_msix() already ends with a readl() flush of
PCI_MSIX_ENTRY_DATA, so when __pci_read_msi_msg() reads back all ones (as
in cycle 18 of the changelog), all three readl() calls in
__pci_read_msi_msg() also failed and the device is still not decoding MMIO
at the moment the retry runs.  Without waiting for readiness or verifying
the retry, the second write and the following pci_msix_write_vector_ctrl()
can be dropped as well.

In addition, pci_write_config_word(dev, PCI_COMMAND, cmd |
PCI_COMMAND_MEMORY) earlier in __pci_restore_msix_state() is not flushed
with a config read before the MSI-X table MMIO writes begin, and the
unconditional readback adds three synchronous readl() calls per MSI-X
descriptor on every restore across all devices.  Retrying via
__pci_write_msi_msg() rather than pci_write_msg_msix() also invokes
entry->write_msi_msg() a second time.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/4EDB2ADA2CFC5963+20=
261126064901.1798104-1-raoxu@uniontech.com?part=3D1
