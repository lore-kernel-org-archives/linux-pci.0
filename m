Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181E12727FD
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800960; cv=none; b=d56IUK8jJJpPaEAA3WII4jLhdqDa42x1yxHBg/CaxAMuqxqG/QRwu16ipT4Z9yOQ6QWa1wb+VILqxd9dXxRJmQurm0JV2btwJn+FOyYS0wDj4+Aks4AN42mAywOHa+eNcI+AU+Ujs768QrWlBlccb2eGB3SM70eIPAKCrx6IiEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800960; c=relaxed/simple;
	bh=2aaA+j96ATu54kIfRUjrZHWPEKT1weTYWyrrAFERnVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMV6GywM/o1dZ9Md5tbiObvEZgopgWkoJERYGuuX1W+SpCTK8lPxvwA2ZLNiuZF7gJ/FZc/GKkY9sZGLvOhPdsU4DOWjGddrmWJEhfKUyZsywDmVLkBq8r01D3DnSQe8oJSsvoe6MM5KAlEToRhiE3C4WzufrIGJAWcZEVbmiGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ET5kSiQq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ET5kSiQq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782800958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2aaA+j96ATu54kIfRUjrZHWPEKT1weTYWyrrAFERnVw=;
	b=ET5kSiQqF1+9TjzvXShcHM58+wDVFbF2tbn2T3EN2+v2jhzXqf1Ao1so9v6+tSTatA1bkS
	zJOY/rydEOps6xMAAXVwqQ3uUr5MDuKVfHF3cwK1vW2uc2G8r/qot1/kgzlVUD24Pm08HT
	KZOF/4bZp18NA8EXTB/Jz4MHXR1fG00=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-WG2wTwo0Meu3YKrqxdSpYQ-1; Tue,
 30 Jun 2026 02:29:14 -0400
X-MC-Unique: WG2wTwo0Meu3YKrqxdSpYQ-1
X-Mimecast-MFC-AGG-ID: WG2wTwo0Meu3YKrqxdSpYQ_1782800953
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED91C19774F5;
	Tue, 30 Jun 2026 06:29:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.35])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D3743000B4D;
	Tue, 30 Jun 2026 06:29:05 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: mani@kernel.org
Cc: alex@shazbot.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	bhelgaas@google.com,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH v11] PCI: Add device-specific reset for Qualcomm devices
Date: Tue, 30 Jun 2026 08:29:04 +0200
Message-ID: <20260630062904.197939-1-jtornosm@redhat.com>
In-Reply-To: <5mrwcurlf6xnqla5x5idpt7ug34nv2eqpijnjmccgdwazrmwyv@64tixxe4aa57>
References: <5mrwcurlf6xnqla5x5idpt7ug34nv2eqpijnjmccgdwazrmwyv@64tixxe4aa57>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Mani,

No worries! v12 with the fix and WLAN renaming is on the way.
Thanks for catching it and your help

Best regards
Jose Ignacio

