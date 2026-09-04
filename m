Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19693932EA;
	Fri,  4 Sep 2026 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548984; cv=none; b=TEfhOQM1Tde+TvuC3V5hAUokcnQvg0XuQ6sBIlNu3+UfwXyhiaI53rhllF/mSYkifl9VEUhxRrMysUYp8UMkc9msfFkznQUJTuKrrqx/8AUjcbpI5Fx3/tmfOOHfEddEgKYEGeF5yN1fyGx1b0e7L5MzWEMvhLbr6kYoyw69kz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548984; c=relaxed/simple;
	bh=yWPKa06wdV33sHqlVbOx/I7hTCE70vq1eC2Tx3A9yTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCeq8M3Jy+RUEkTYx8lzzwxgM1gKM2GwcPy9w8L/EuOhK4pkddLLezC+gg7kiGJW5z768NXoTsRwQSPh6RX2nOK18vlXgd3DLIqKa315o7HC3h+Kd03Wd1pO8JeN0BrNFjI8nF848uBuPrmEDwjPxBFv59LIjhsBCTSt794GiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=jq/mNMIB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nIxBGEEJ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="jq/mNMIB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nIxBGEEJ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B511F7A00F8;
	Fri,  4 Sep 2026 15:09:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 04 Sep 2026 15:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788548972;
	 x=1788635372; bh=5lMGz/z9spGna6kQNQ5IoPLGwwwI+xjju3MdKu2x6uw=; b=
	jq/mNMIBi9cvY0h1nfSJpzCstgNCyRktuPNQPrhjr++EQ5lq+Isas5ShlePXLbHU
	oScCIngyuu9Zc8xe5dpqVTE6SeTnhF3+WLPEqbMr64RglLIePxHnHewtbsl6hTw0
	Sn/i6ZM9WDWaX1eR6usVJYBH5ZfN5oeBaMoJbG9+Krv6C5mpT3GoyOZLlJ4lnvAt
	mhH7cneQSafg7GG1a6OZKs1w9glC+TwSX3wIUaLquZMyk3tA3q/Fkz6F687wJ8LO
	c5SM8p7ZL+qY99Z47h2wuxjUGulP/JlLXMkp+tPAe4aaa6Lf1uA//ljVqtFOqeSk
	y5+X7amUcfG8cJtLqBIrNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788548972; x=
	1788635372; bh=5lMGz/z9spGna6kQNQ5IoPLGwwwI+xjju3MdKu2x6uw=; b=n
	IxBGEEJcpEzqlCBzJo9l6bEyS+QBIqTHANd6Vfl9Mw/gOeZGnMOp0lzwJ8NMP/5K
	JcwuVhbRkKgOW88zk7nCntxHrolaOBn13iRhxvqTpQ0iIuDPsViS9Xu8nTP3uzx4
	IqoHSsVCOuK+Us8x9J8wYVUZGV3Ju0OVAQsSGoR9rNyK2qaJuvZCjiMOUPUK2rqt
	zHmYf86HYpPhTxX9+g4ZvwcJsBj+fGI2+FzOjnitUaGntfuTO2AoME0BfE5738LM
	saiZlB9AUWaPEqhqVKOFlAt70yRID5t86paM2UrHQWP6DOPWrUVJTdTYX/wiYWIa
	XEQM8kks8U3gcU49B/7Wg==
X-ME-Sender: <xms:bBebaqBnLjZiPWng4I6BkBXlRl5oGOhEiMS9HgVEALbCWG50aAqIpg>
    <xme:bBebahMrBhhuANVAiH3fHJzVjxuRd9Unhf9w0WsHuG5JnwSWg2wK419ljSA59gPS1
    uYgN6hwRDs8srs1HwVAOo6ICWqT2A8QvwOLtUmMngik73Ot96YL_iA>
X-ME-Received: <xmr:bBebahdMxW5ry8666S63gmlvBLgJPeGZnaMaWRmVEdVPObiLz8OOwhwti8PoVA>
X-ME-Proxy-Cause: dmFkZTGcr6jmw64IquojJXpO2xtMve9/1B/qGAWt8VlMJG3AMBpF8pcof42bRMl7lkRST6
    V3TFG3M9cRm1maws1qb7zDhAolJbFVF8lpoq3lKiIUGn+BtFvUTtqbIy0OGFM5WPhNBenm
    PPzUpC0RF26LrjGDdPx4tAX8Qg1FikmK53UEqVvSuMCc/VTwz5ZYmWXfIttjajpmrIm8YS
    QJ2yF6FJnA/2cuPPlan0lVU10TaWYop87ozaSzVZHVa9BSJFidAvmcloEBchiWvEEP+a3d
    Xx4tVbJ8657Pq6IPXY0rYEl1NvfOsEikDTwkFOVZwItcIR/MJLEPhgzv+T27OehKZBHxZ1
    FnL+ga564ONOzNqA2cITQdPH2rAbgaYVebENDpjGtn8ywguojwQuE5/mMNpRv4BUPCs5DP
    dUY1c6i3vUVaNaXTg6orJI/XQc+XOPM+D5j+GLmKbVS3I825KVsNNOgjxg1rQHFOpilG2L
    F1p5jgTmNvkZILNPMPr/Yo+jZxYV3h/RbQ9cPFQTfLIuJTEHU2mtl3az3DYuqrR7OtCtZI
    d9WlVUb1TYEe0WRqJCHqCWzCbfAB37E1oQ2rb2wzhf7i4dgJZyfjrpkTCUN1aT7yMjUAqR
    PKe7GOoxtmmnSeK1jlO02YNpFFOM3E9ej8C4gA6or1ZhMkuDPhFDh3my24cg
X-ME-Proxy: <xmx:bBebai4DWCF_TRw33uGRKWDLWN6-e42jEqnKfERWu_ACrFCcWTTNjA>
    <xmx:bBebajL8M9-uZMPayhjUqs7IgX_OaKkh6rD1N8yMXcXUgWtiNzW4qA>
    <xmx:bBebasWUT8iamnE9TDUu1QIKfdkxCUKOcm9LAhudO-9HQJ0RNybLwA>
    <xmx:bBebavHdkeTsKvtT3Ewb-zJwUWCFhIGvgormc4EoKbpV4ZWWooCwcg>
    <xmx:bBebaj64aH-6QVOwj2TAs96utFYYvZfNcuv-AjiaFJ4H0sQqCh_FhwAy>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 15:09:30 -0400 (EDT)
Date: Fri, 4 Sep 2026 13:09:27 -0600
From: Alex Williamson <alex@shazbot.org>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
 <kbusch@meta.com>, <michal.winiarski@intel.com>,
 <satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, alex@shazbot.org
Subject: Re: [RFC PATCH 00/19] vfio/pci: Handle PCI error recovery and
 report state to userspace
Message-ID: <20260904130927.2e234a21@shazbot.org>
In-Reply-To: <20260901093217.8539-1-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Sep 2026 10:31:58 +0100
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> Hi,
> 
> Currently, vfio-pci takes almost no part in PCI error recovery. It
> implements error_detected() and neither of the other two callbacks. That
> one callback ignores the pci_channel_state_t it is given, signals the
> error eventfd, and returns PCI_ERS_RESULT_CAN_RECOVER for every error, a
> permanent failure included. Nothing implements slot_reset() or resume(),
> so vfio-pci never learns that the host reset the device, or that
> recovery finished.
> 
> Userspace gets one eventfd signal with nothing attached to it. It cannot
> tell a non-fatal error the host recovered from apart from a permanent
> failure, and it is never told when recovery is over. With nothing to go
> on, QEMU assumes the worst and calls vm_stop(RUN_STATE_INTERNAL_ERROR),
> which the VM cannot come back from.
> 
> Any device assigned through vfio-pci can hit this. A non-fatal
> uncorrectable error is reported, the host AER path recovers the device
> fine, and the VM is killed anyway.
> 
> This series lets userspace observe host recovery state, and keeps it off
> the device while recovery is running. With that state visible, userspace
> can decide what to do with the guest rather than assuming the worst.
> 
> The approach here comes from an earlier discussion with Alex.
> 
> https://lore.kernel.org/qemu-devel/20260707161234.23ed28db@nvidia.com/
> https://lore.kernel.org/all/20260818083754.7ccf76d9@shazbot.org/
> 
> Design
> ------
> 
> The VMM watches recovery. It does not take part in it. The kernel runs
> the recovery sequence and tells userspace what happened and when it is
> done.
> 
> vfio-pci already has error_detected(). This series extends it and adds
> the other two callbacks:
> 
>   - error_detected() now records the channel state, blocks new device
>     access, revokes BAR mappings and exported DMA-BUFs, and quiesces
>     INTx. It still signals err_trigger as it does today. It votes on
>     severity rather than always claiming it can recover: CAN_RECOVER for
>     a non-fatal error, NEED_RESET for a frozen channel, DISCONNECT for a
>     permanent failure, and NONE if our own quiesce failed, which leaves
>     the rest of the domain alone.
>   - slot_reset() is new. It restores config state after the host has
>     reset the device. Nothing does that today, which is why a device
>     comes back from an AER reset with its config lost.
>   - resume() is new. It restores PCI_COMMAND, unblocks access and wakes
>     waiters.
>   - A new device feature reports the state and carries an eventfd.
> 
> A non-fatal error gets the same quiesce as a frozen one. The host has not
> finished deciding what the error was, and can still escalate to a reset,
> so the device is not the user's again until resume() says so.
> 
> The support is opt-in. Until userspace installs the recovery eventfd,
> generic vfio-pci behaves as it does today. error_detected() takes its
> existing path and signals the same eventfd. VFIO variant driver support
> is not added for now.
> 
> The uAPI is VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY. It carries the
> eventfd and reports a status word plus a sequence number, so userspace
> can tell coalesced notifications apart. IN_PROGRESS is set while a
> recovery is running. CHANNEL_FROZEN says the link went down.
> DEVICE_RESET says the host reset the device. FAILED says the device
> cannot be used again until close and reopen. ENABLED says userspace has
> opted in.
> 
> A non-fatal recovery can complete before userspace reacts to the eventfd,
> so IN_PROGRESS may already be clear by the time the feature is read. Work
> from the sequence number and the status bits rather than expecting to
> catch the event while it runs.
> 
> Patches
> -------
> 
>   1-3    the groundwork: the recovery state fields, the open and close
>          lifecycle so a callback never sees a half built or half torn
>          down device, and the access guards the rest of the series uses
>   4-13   close the access paths one at a time: function reset, config
>          space, ioeventfd, BAR faults, BAR and ROM, interrupts, hot
>          reset, runtime PM, info queries, DMA-BUF
>   14-18  the error handler callbacks: slot reset, the INTx helpers and
>          the quiesce that uses them, then resume and error_detected
>   19     the uAPI a user opts in through
> 
> Locking
> -------
> 
> Blocking access is the hard part of this series, and it comes down to
> one rule.
> 
>   recovery_lock can be held while publishing state, and while draining
>   operations that are already under way. It cannot be held across a reset,
>   or across anything else that reaches pci_bus_sem.
> 
> The reason is the order AER arrives in. It enters the driver already
> holding device_lock, and pci_bus_sem too when the device sits under a
> bridge with a subordinate bus, and only then takes recovery_lock. A
> secondary bus reset reaches pci_bus_sem. So a vfio path which holds
> recovery_lock across a reset ends up taking those two the other way
> round.
> 
> Seven places needed reshaping for this rule: device close, slot_reset(),
> open, VFIO_DEVICE_RESET, the guest triggered config space FLR,
> VFIO_DEVICE_SET_IRQS, and a guest write putting the device back in D0,
> which reaches pci_bus_sem through pcie_aspm_pm_state_change().
> 
> Most access takes recovery_lock for reading and checks whether a recovery
> or a reset is blocking the device. A few places cannot take the lock and
> read that state directly instead. All of them fail safe. A stale read
> costs an extra refusal or retry, never an unguarded access.
> 
> Interrupt teardown is the one deliberate exception. It flushes the global
> virqfd workqueue with recovery_lock held, which can make the hold last as
> long as a reset on another vfio device. It costs latency, not
> correctness.
> 
> I am not sure this is the best way to handle it, and would welcome
> suggestions.


Thanks for tackling this, Shameer.  The recovery_lock wrapping all
these accesses does make me nervous, both in lock complexity and
overhead.  Wouldn't it be a better solution to decouple the user
interface from the device by replacing the access path via SRCU then
doing zap/move/interrupt teardown?

Such a solution would have utility beyond the error path.  We could use
it for surprise removal/DPC, we could allow a policy to remove the
device from the user on unbind, in place of or in addition to the
request eventfd we use currently.  In the error case, the intention
would be to temporarily suspend access to the device, but if it falls
off the bus after recovery, it may turn into a permanent removal.

What do you think?  Thanks,

Alex
