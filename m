Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59707426EB0
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108271; cv=none; b=C1wSOioD0fxORuWMg+0uDEDTKofUcszR2zleCMrN8DkHgHSPc3AC8kqcKIdaiL3tj5xWf2iwQwXF9lDoiskPmnsxtlZN8jCmFrbeHVl9CTe4qFYM7Ya9kTEDqNiXvL9fcm3vwOHz+DTyv1oqvu1x3L75iG8m1FvMnwMtGdb7Iz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108271; c=relaxed/simple;
	bh=2CnyVHidrdlQDuwgMeOPpQpWLGATeUtDG3tX7zAdP00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=on7J4KCe7QjV2fmbLHsThg9Te4eH3ydtJI0KB1uoROkmyyo6a8eJGPtSC252D39zlm6pPAbiiF5o2E9g7FUSFfiCjipKl1l2oxMHU0dhcaWRM5G8m7/sjQXz16PGMkwT60LY8hW4fgGzQH0VzT0L8n6cfdh0KprxOgkkUgdb8wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XIeY4uDW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIeY4uDW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779108269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gEQGpsYTmnpq9HI4VWGz+9x4gXayjeosVcnUrZ4sVA8=;
	b=XIeY4uDWw/CGrcfGkOwZM1kHS4Ze/uMh1Q2WHTFw7UuZhei1yMha+XF6elRu2SEeM63plP
	bP1Pu2czywDXh4g6JlbbEAO7iSSBydrkvopD0Pf0La/kAY3b5vl2T/6DR3jdIxyJ+IOIKn
	7HSEukm0vx4dSdfwLHYtEzbEnl5o4BQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-L2jCO5fxNoadfBKwVVcO5Q-1; Mon,
 18 May 2026 08:44:27 -0400
X-MC-Unique: L2jCO5fxNoadfBKwVVcO5Q-1
X-Mimecast-MFC-AGG-ID: L2jCO5fxNoadfBKwVVcO5Q_1779108266
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4409F195608F;
	Mon, 18 May 2026 12:44:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.67])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B58B31800465;
	Mon, 18 May 2026 12:44:23 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: alex@shazbot.org
Cc: bhelgaas@google.com,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: Re: [PATCH v3 1/2] PCI: Add D3cold as general reset method
Date: Mon, 18 May 2026 14:44:20 +0200
Message-ID: <20260518124422.460518-1-jtornosm@redhat.com>
In-Reply-To: <20260514145452.44f9ac5b@shazbot.org>
References: <20260514145452.44f9ac5b@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello Alex,

Thank you again for the detailed feedback.

> Are you testing with the patch that marks these devices
> PCI_DEV_FLAGS_NO_BUS_RESET?
Yes, I'm testing with quirk_no_bus_reset applied.
My evidence about bus issues with the commented Qualcomm cards is
device-specific and not adapter-specific because we are using the same
adapter with the commented MediaTek MT7925e
- Uses quirk_no_flr (https://lore.kernel.org/all/20260511123936.36054-1-jtornosm@redhat.com/)
- reset_method shows: "bus"
- Bus reset works correctly for VFIO passthrough reuse
This proves PERST# is properly wired through the passive adapters. Since
Qualcomm devices fail SBR with the same adapter setup where MediaTek
succeeds, I think the issue is device-specific, not deployment-specific.

> I want to be sure that bouncing the device
> through D3hot is actually an improvement versus no reset at all, and
> we're not just performing a no-op reset to avoid the bus reset.
The D3hot transition is definitely an improvement over no reset at all:
- Without any reset: Device remains in undefined state after VM crash and
  cannot be reused.
- With D3hot transition: Command register gets cleared (0x0002 → 0x0000),
  device can be reinitialized and successfully assigned to the VM
Testing methodology: VM crash → check PCI config space → verify device
reusable. The D3hot transition clears enough state for VFIO passthrough
reuse, even though it's not a full FLR-style reset.

> That said, if you're testing before BAR restore and those registers
> aren't being cleared, this seems at best a device specific reset, but
> evidence is a bit sketchy. In the general case, a transition through
> D3hot for a device that does not claim NoSoftRst- cannot be consider to
> satisfy a reset request.
Agree, my testing confirms:
- Command register: CLEARED (0x0002 → 0x0000 → 0x0506 after driver init)
- BARs: PRESERVED (0x84200004 maintained throughout)
So, this is a partial reset, not a full spec-compliant reset and only the
command register is cleared. However it works.

> If you can block the known broken resets and manage to trigger a D3hot
> transition externally, that may provide a reasonably useful environment.
> We've also been known to implement the sketchier resets that can't fully
> be justified as a kernel quirk in QEMU itself.
I understand the concern about sketchy resets in the kernel. 
I have prepared v4 version with a different conservative approach not
changing anything in the current behavior, as a last resort and only adding
a "soft" method when other reset methods are not available (our current case
for Qualcomm cards).
I believe providing it as optional kernel infrastructure (user-controllable
via sysfs) has value because:
  - Benefits all VMMs (QEMU, cloud-hypervisor, etc.), not just QEMU
  - Uses standard PCI PM mechanisms, no device-specific hacks
  - Provides measurable value for VFIO passthrough where no reset exists
Happy to adjust based on your feedback

Thanks

Best regards
José Ignacio

