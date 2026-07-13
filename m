Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1C13BFAC8
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932765; cv=none; b=D2a40XYa6AtMDnKv6CQ5A/85f/pZGMHPD7XoyrC08yiUpFJRJU0E2uJh+ThIDiMJSDUC++21M9SFWWzOQLGNUxkQ+mw1rP3EXoBlxAz3q+fbuhWHMZrdVxmnlkZkXWjRD977WaSWuDUTxGQKDHyh9wwB2VEXeHsyn+4iLB5bUho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932765; c=relaxed/simple;
	bh=j3u6ZVOegncLBhyB7QqeGqwENQdMo2jsFVdKa1ooIAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBomplFkcJRwQva27KHWF0E7bDHKKW3Pp7Jcx8gZriJXOickWKRSkfYIr6BthTkqyg2mGfO0wJqJDzjjvqVCbJwAe3fnvlATyQYDltSO3/1IH0v4K3FoGnvX03k0mFsEAFzFOP0wCY2KQmwcMosJZWRoWRcX6/OWxBTpOj3nKsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8vxxfbo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8vxxfbo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783932762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3u6ZVOegncLBhyB7QqeGqwENQdMo2jsFVdKa1ooIAM=;
	b=F8vxxfbo3DgPUQ9/shM0U4EgEZVz0d3sGRVVmIH3fE4LHye0+KvQaqAIk2MHvsi1Zhkwl9
	wyWv2F2XxFb8cmA/ZDBb1FnTL1EZTdF17N1rsftTeoD0WsRFEOixcjkd+mhbCaCy8h8NCt
	15rEdV8DW2tDbNvoZBunRLgQOzpLVOo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-EhByDjCIMD-IhsC4tuxANw-1; Mon,
 13 Jul 2026 04:52:37 -0400
X-MC-Unique: EhByDjCIMD-IhsC4tuxANw-1
X-Mimecast-MFC-AGG-ID: EhByDjCIMD-IhsC4tuxANw_1783932756
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27D371805A10;
	Mon, 13 Jul 2026 08:52:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9228E195604B;
	Mon, 13 Jul 2026 08:52:34 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: sashiko-bot@kernel.org
Cc: jtornosm@redhat.com,
	linux-pci@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v12] PCI: Add device-specific reset for Qualcomm devices
Date: Mon, 13 Jul 2026 10:52:32 +0200
Message-ID: <20260713085233.411519-1-jtornosm@redhat.com>
In-Reply-To: <20260630070914.3B5E61F000E9@smtp.kernel.org>
References: <20260630070914.3B5E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

> [Severity: Medium]
> If the device is hung or the link is temporarily unresponsive, could the
> initial ioread32() return PCI_ERROR_RESPONSE (0xFFFFFFFF)?
>
> If it does, this read-modify-write operation would write 0xFFFFFFFF (and
> later 0xFFFFFFFE) back to the device. Could writing these values trigger
> unintended resets across the SoC or leave the hardware in an invalid state?
>
> Would it be safer to verify !PCI_POSSIBLE_ERROR(val) before modifying
> and writing it back?

The read-modify-write on the SOC_GLOBAL_RESET register replicates
the existing ath11k/ath12k driver reset sequence
(ath11k_pci_soc_global_reset()). If the device already returns
0xFFFFFFFF at this point, it is unresponsive and writing to it
will not make things worse - the purpose of this function is
precisely to reset a device in a bad state. The link recovery
loop below already handles the case where the device remains
unresponsive after the reset attempt.

> [Severity: Medium]
> Is this polling loop vulnerable to false timeouts due to scheduling delays?
>
> If the thread is preempted during msleep(20) and delayed for more than 5
> seconds, time_before(jiffies, timeout) will evaluate to false upon waking
> up. The loop will exit without a final check of the register, returning
> -ETIMEDOUT even if the link successfully recovered during the delay.
>
> Should there be a final condition check after the loop, or perhaps use
> read_poll_timeout() instead to handle preemption robustly?

The time_before()/msleep() polling pattern replicates the existing
driver recovery logic and is standard kernel practice, used
throughout drivers/pci/quirks.c and PCI core. A scheduling delay
exceeding 5 seconds would indicate a severe system issue beyond
the scope of this reset function. The 5-second timeout is generous
for what typically recovers in under 1 second.



Since the implementation replicates existing driver behavior,
both points were already discussed during review with the
subsystem maintainer, and are handled in the code, no changes
are needed.

