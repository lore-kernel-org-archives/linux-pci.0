Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A08377550
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502394; cv=none; b=sQ2WLyqo/2fKrEL7u1RCwghU2KWs3m2FAlnL9CoZByeKNBD4e5T54cNRRSdUeTftM+0OLxJOchxGJt+AP65XLt7885DL5W2htxmao2+Rpdk+9g+xwoEbNh7MJwNkixQGEWPzaPRBWjDIT29M2msO1emcl8+MAYKovllO7ngM7ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502394; c=relaxed/simple;
	bh=iolC6bBCO1uBO8OTxwxvAtERm7HvcVUo1Pbh8DX4BIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alqDv/hNuTPTKqjGe0GXbZdVoVOmLwbDjgbxbQEUMCBhU9c0oCUt/5bHGELhWIQpqumKAJEG/HvUK7lBehzUukTVElmmQAJwc1khmwBYoBp0fkifW8yW3vUTTiQzgqxy/J0ZXbvuHObFNsWKRmk773CHsn0z8+Gi+MEYF/3kvxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvkNlDzv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvkNlDzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778502391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0esOW+E5aORR+Jaz2Vzk879TLZQqwTPc1YcmsqDi+5U=;
	b=hvkNlDzveI+838j5KLaXz6UOfLxTZug1xC35rm+iEBn31LknHoxwtDB6nnWDMVtC9/O6It
	4fdMGieUyG0a8RmmCJMTS6cDrP7LcGhM/MArnUxIHgK3ioAjGLoSrGrjiUwGOfE/6c58g6
	K13wMziBEmV+cMkx2b5I47kBoTQukCE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-P12XTs3qP0Ocq_ZCqrkx6A-1; Mon,
 11 May 2026 08:26:29 -0400
X-MC-Unique: P12XTs3qP0Ocq_ZCqrkx6A-1
X-Mimecast-MFC-AGG-ID: P12XTs3qP0Ocq_ZCqrkx6A_1778502388
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C823195607B;
	Mon, 11 May 2026 12:26:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.142])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5BCC91800286;
	Mon, 11 May 2026 12:26:23 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: alex@shazbot.org
Cc: bhelgaas@google.com,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Force PM reset for Qualcomm devices with NoSoftRst+
Date: Mon, 11 May 2026 14:26:21 +0200
Message-ID: <20260511122622.35311-1-jtornosm@redhat.com>
In-Reply-To: <20260508111627.702c9be2@shazbot.org>
References: <20260508111627.702c9be2@shazbot.org>
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

Thank you again for your review.                                                                                                                                               
                                                            
> What does reset_methods sysfs attribute report for these devices on an
> unpatched kernel?
The kernel we use doesn't have CONFIG_PCI_RESET_SYSFS enabled,
so reset_methods is not available. However, I can provide the actual
behavior observed through testing and dmesg logs.
 
> I'd tend to expect these are single-function devices where bus reset
> would be available as a function level reset.
Yes, these are single-function devices (PCI header type 00).
For example, here's the ath11k device:                                                                                                                                                                                 lspci -xxx -s 0000:03:00.0 | head -2
    03:00.0 Network controller: Qualcomm Technologies, Inc QCNFA765
    00: cb 17 03 11 06 05 10 00 01 00 80 02 10 00 00 00                                                                                                                                                              
                                                  ^^
                                     Header type: 00 (single-function)
 
> I'm very suspicious that this is just masking an underlying issue
> relative to bus reset for these devices
Yes, you are right, there is an underlying bus reset issue. Let me explain
what I have observed through the testing:
Testing showed no reset is performed at all. During both VM startup and
virsh reset operations, there are no reset-related messages in dmesg.
The reset hierarchy returns -ENOTTY at each step:
  - No FLR (device doesn't advertise it)
  - PM reset returns -ENOTTY (NoSoftRst+ flag)
  - Bus reset apparently not attempted
When testing the suggested quirk_no_flr() approach (which worked for
mt7925e), dmesg shows secondary bus reset is attempted:
  vfio-pci 0000:06:00.0: enabling device (0000 -> 0002)
  vfio-pci 0000:06:00.0: resetting
  pcieport 0000:00:1c.4: unlocked secondary bus reset via: __pci_reset_function_locked
  vfio-pci 0000:06:00.0: reset done
However, the device becomes unresponsive after this:
  lspci -vvvvvvvvvvvv -s 0000:03:00.0
    03:00.0 Network controller: Qualcomm Technologies, Inc (rev ff) (prog-if ff)
        !!! Unknown header type 7f
And all config space reads return 0xFF, indicating the device is not
responding after bus reset.
If we use PM reset (D3hot->D0) succeeds and the device works correctly
through multiple VM lifecycles (startup, virsh reset, shutdown/restart).
                                                                                                                                                                                                                     
> especially if we haven't actually verified the device state is                                                                                                                                                   
> actually reset on transition back to D0                                                                                                                                                                          
The verification is functional: with our patch, the device successfully
initializes in the guest after VM reset operations, and continues working
through multiple reset cycles. Without a working reset (default kernel),
WiFi devices (ath11k, ath12k) cannot be reused after VM termination, and
modem devices (SDX62/SDX65) fail to initialize even on first VM assignment.
                                                                                                                                                                                                                     
Summary:
You're correct that there's a bus reset issue, SBR breaks these devices.
The question is whether we should:
  1. Investigate why SBR breaks these single-function devices
  2. Use PM reset which demonstrably works
Option 1 may involve firmware-level investigation, while the PM reset
approach provides a working solution.
This situation is similar to existing quirks: quirk_no_flr() works around
devices with broken FLR implementations. Here we're working around devices
that incorrectly advertise NoSoftRst+ (preventing PM reset) while SBR doesn't
work properly.
I'm open to your guidance on the best path forward.

Thanks

Best regards
José Ignacio

