Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A21433066D
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778238341; cv=none; b=d3K/RVfQMjl6yC12R4WoZH/Jw8lvlj1oGUjDhOhgCpFTKBOpWo5NuNNr2Jgo4Zid/R1lB9lm4Fe8HG9u5TJgn3lG+0gr0WhM8wiCUs98H6EvA2H02T8XtrxQs39HYeR9GxoPbnLIimWcq0Ed37MJXS0YptuwlGg3Mv9xe3oNB8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778238341; c=relaxed/simple;
	bh=tPJmN/Px4gJyHB5F8yCPj8wIFl1IKwa4SlkCOLxI6s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsHahi1KyVUt7Mjo2bGvkWbwes3RF7KW+bnBsgbsOVu8HD4LknE8obte8S9h5PWGPW67IaiFYqQs65NfgD8S3vb8D85PYbQVU42giAq0osds58eoGLE8ld4tJLjWZA8FiPROIBhlQF06NBaxMe/fAwGFw/+G+/oixoqqK9eQ+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PDcmHjff; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDcmHjff"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778238339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDJJ/vJ8Sth18hzvtmIGnBG0yOgB6g0oyL7k80FQI5c=;
	b=PDcmHjffk+TPg+XBUslKWyCBXGNt7XJZFjZ3P95JUjWb66h2dRMZZr201epKb6PbzNMMre
	yZXlD/Uaa/qMVhCgRkH8+qAOipVoXYDYq3vYPAyLDno9ynlvh8GQgickLqEF4hZ3vcf2Yi
	VhGOW4yxzfKvG7IhMPk83fg4QhBKDPo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-b9jUN04kM-KrVgYfgPUkng-1; Fri,
 08 May 2026 07:05:35 -0400
X-MC-Unique: b9jUN04kM-KrVgYfgPUkng-1
X-Mimecast-MFC-AGG-ID: b9jUN04kM-KrVgYfgPUkng_1778238334
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0165719560B0;
	Fri,  8 May 2026 11:05:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.23])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B06FA300019F;
	Fri,  8 May 2026 11:05:31 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: alex@shazbot.org
Cc: bhelgaas@google.com,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add D3cold reset quirk for devices with broken/missing FLR
Date: Fri,  8 May 2026 13:05:28 +0200
Message-ID: <20260508110529.458971-1-jtornosm@redhat.com>
In-Reply-To: <20260507092518.186c7f1b@shazbot.org>
References: <20260507092518.186c7f1b@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello Alex,

> We should not have driver dependent reset behavior.  If FLR is broken,
> add these devices to the list of devices using quirk_no_flr() and we'll
> fall back to another reset method.  We also shouldn't be implementing a
> variant of pci_pm_reset().  PM reset can also be prioritized over FLR
> via the reset_methods sysfs attribute if the reset method really is
> tied to the usage.  Thanks,
Thank you for your feedback and help

I tested quirk_no_flr() and it works perfectly for mt7925e. The related                                                                                                                                            
mt7922e device was already in that list so this was expected.

However, for the Qualcomm devices, that solution doesn't work and they
need a different approach.

So, I will submit two independent patches for v2: one for mt7925e following
your suggestion with quirk_no_flr(), and another for Qualcomm devices with a
different proposal trying to follow the same idea.

Best regards
José Ignacio

