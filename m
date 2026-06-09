Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBEB3630A0
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028211; cv=none; b=py7msl/6N6OEagN4KsPodweK5ecVU9JZWzKQEV8fUaHuAlgc9Mep9ENxNqACPva4o1coB0OdD0N97h3zw9WMwmEk4INQgjGQeeD3fw7yrljM990SdIfs2+OsU+AlPyFnyrhD/mfxITEva5Ld7O+QkcsGBkfCtCL55qCqs4lrs7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028211; c=relaxed/simple;
	bh=G6fKcCO57CKECuSzoFqB1/I3EyviZ60sfF9sJj+6t2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TgAa/nfqE9/JfawonRDj7Ei3wHUrnTcGX+PQ3FzRN1zSC2/PDFhkqbSCwjJc8GH3UwE8IT+klgpe7mkoZSz3PnmLyW1WnFznDPy53uf0U2FoUQDNaLiUAhPiE9PtCeMNth/N16SaaJ6bzNyEWYQRWCbzTOsfBgyiNz0BiyA2bFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRs5ApGt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRs5ApGt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781028209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lp7h1DEVUYMXTnwExPf6dnTbeZPEaw/Wv2Y/FANT1G8=;
	b=DRs5ApGtZUnbDCoxADmf5sPRCkb3zlaTmceoiQNsHW9WFx428LfUXxg/vMXDg5IbI120qP
	bnmsS57EX2KDuMeqYT7K2Khu3XLLBKdooIBvYiGgEeUkvBr5VtwSf8RBrVl6SQadm4J5iv
	VuRN+FvwUtnoAKdcdb3OPkrwbSkpLYo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-rUQ8zL53OqyX13dC-mbQ8w-1; Tue,
 09 Jun 2026 14:03:27 -0400
X-MC-Unique: rUQ8zL53OqyX13dC-mbQ8w-1
X-Mimecast-MFC-AGG-ID: rUQ8zL53OqyX13dC-mbQ8w_1781028206
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BC981801316;
	Tue,  9 Jun 2026 18:03:26 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 555F218005B8;
	Tue,  9 Jun 2026 18:03:24 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jinhui Guo <guojinhui.liam@bytedance.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v4 0/2] PCI: Suppress lockdep warning & make pci_call_probe() more efficient
Date: Tue,  9 Jun 2026 14:03:13 -0400
Message-ID: <20260609180315.850637-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Patch 1 suppress the false positive lockdep warning when there is a
nested pci_call_probe() call. Patch 2 makes pci_call_probe() more
efficient when the current has been affined to the right node already.

Waiman Long (2):
  PCI: Suppress false positive lockdep warning in pci_call_probe()
  PCI: Call local_pci_probe() directly in pci_call_probe() if affined to
    the right node

 drivers/pci/pci-driver.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

-- 
2.54.0

