Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D516367B60
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345146; cv=none; b=jYjGLTArZek2o2ndT7iFV+QHIWP0jhogq/7C005H3b7VdnXf0fm7SdyucCRRZP93MT8XJzQBD6GdQrXyYhhxY3DQWcr7msxT8V6A3vSQwhEL7ElCo5RwD7FmmyGFq3dQFbPWxUCcLJJXf+HpQfjUPKDFGFmux6y8lX/SFn1iBb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345146; c=relaxed/simple;
	bh=e/u0Xs6TkrR6asLCcO2kGwyprE5amFm3MDU97vP/aSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8wQS8oQAJC/FEJJDPGlOGg6jg3eXg/i9+w/rnDHVK/vJ2qV759s0eNUjzKRV79bdg3In1nGqsbjlKXuEfUBVpz5bHgZ8SFfM/u49ZkfJ4rRRqgloe9thIn8qkri6u15Ub53D2kxGcKn6Ngf/2AL9rFV3+BH/Sj0lhk5Qfvossg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PfWlJv38; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfWlJv38"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779345144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/u0Xs6TkrR6asLCcO2kGwyprE5amFm3MDU97vP/aSE=;
	b=PfWlJv38KHInpmd6ka0tce20azdNUC+q7TkRG7cwTRaKOn+athOrnmr+yRWJUwxVkP8LaC
	ZJDXnSjvB5kmrzu1hfxfP/4fsuKnHrwTe89ITHWFidEjXPdBYA/dzkTxplBXY55xSGBJSB
	qs5Ovvmo7pFPkSWFy6sd1SaOQ/XBaQk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-YWknI6pDMhmAN4Uv17Q2KA-1; Thu,
 21 May 2026 02:32:19 -0400
X-MC-Unique: YWknI6pDMhmAN4Uv17Q2KA-1
X-Mimecast-MFC-AGG-ID: YWknI6pDMhmAN4Uv17Q2KA_1779345138
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA6E918002C7;
	Thu, 21 May 2026 06:32:17 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D0F291800352;
	Thu, 21 May 2026 06:32:15 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: alex@shazbot.org
Cc: bhelgaas@google.com,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/3] PCI: Add soft reset method as last resort
Date: Thu, 21 May 2026 08:32:11 +0200
Message-ID: <20260521063214.13180-1-jtornosm@redhat.com>
In-Reply-To: <20260520101338.21fe1e13@shazbot.org>
References: <20260520101338.21fe1e13@shazbot.org>
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

Thank you for the guidance.

OK, using pci_dev_reset_methods[] makes sense.
I'll implement device_specific reset entries for the Qualcomm devices using
pci_set_power_state(dev, D3cold), which automatically falls back to D3hot
when the platform doesn't support D3cold. This handles both scenarios
(platforms with and without _PR3).

I'll keep the general d3cold reset method (patch 1/3) as well, since it
provides value for other devices that need strict _PR3-based power cycling
without D3hot fallback. The device_specific entries are the Qualcomm-specific
workaround, while d3cold remains general infrastructure.

I'll also keep quirk_no_bus_reset as a safety net to prevent the known-broken
bus reset from being attempted. This ensures that if users override reset
methods via sysfs, they can still use d3cold (when _PR3 is available) without
accidentally falling back to the broken bus reset.

Thanks

Best regards
José Ignacio

