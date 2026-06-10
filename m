Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864FC3EA970
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781085677; cv=none; b=dhES+ihysjw4f5jnePKcXh+3U2tgcyH28kAzoknyjeJL/9D3ZUiDmxjXQ6waA1SOzN1zFAhBPgvQErK03RMDnqAimDGXLNwG+SYjF/mT8FRfGeiMjlhj7nLNXUIf9Wflt1tRFrO9tLUjzuOYD8+XHSh1SpBN8vZQjy+pWfSSjpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781085677; c=relaxed/simple;
	bh=NXj8s/f7UZBoXS9eyuxmfRgMWd0CvdIZLbRTYsC+3F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/gXh1s44NkPT1lrVgae5o4B2GF0VCh5snnSVJerxVnWFCXKy5jLhQgMq7zGujkzu/Syfl1pzLUP8sMTFH3bY0R1mjUp4ecX2i7t51QQhudkBaNHODxUp7o2oO18HxqtfEmFZkulTHvGfzVPxb4/6r1w+uiErOSwwv6T6RXjOHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RccKFJtD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RccKFJtD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781085675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0u3YOlBGasTqI/efMg4dbBFjH2Jdl45+ZYBRiUMwLY=;
	b=RccKFJtDPo4DgG2felsRZuSHKS3o3EGgPrRgJL828fwwg3jYhVzfha6ylkHdd7joxMLSd9
	4WzNE4foYkOizU+2hDx2JyH/Fgr4CtDIe9tkZVcFyIswLXKl268Lfa8l/ZBlpor0QgsHRA
	ouXglVIIDJy9AU5APEHR9vQeyQeSYBs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-kRo-Y_WdOd6I7y7utJw08Q-1; Wed,
 10 Jun 2026 06:01:09 -0400
X-MC-Unique: kRo-Y_WdOd6I7y7utJw08Q-1
X-Mimecast-MFC-AGG-ID: kRo-Y_WdOd6I7y7utJw08Q_1781085667
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 505BB1845575;
	Wed, 10 Jun 2026 10:01:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.27])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E818C1800599;
	Wed, 10 Jun 2026 10:01:01 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: alex@shazbot.org
Cc: ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	bhelgaas@google.com,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mani@kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH v8 2/3] PCI: Add device-specific reset for Qualcomm devices
Date: Wed, 10 Jun 2026 12:00:59 +0200
Message-ID: <20260610100059.19235-1-jtornosm@redhat.com>
In-Reply-To: <20260609115352.32acb6fe@shazbot.org>
References: <20260609115352.32acb6fe@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Alex,

> My only complaint is that this is positioned a bit generically...
Ok, I'll make the comment of the function more specific for these Qualcomm
devices.
  
> Has each of these devices been tested on a platform where D3cold is
> actually achieved through this method?
No, I don't have access to platforms with _PR3 support. All testing was on
M.2 adapters (D3hot fallback only). Since D3hot works reliably and D3cold
is a stronger reset mechanism, the approach should work - but I cannot
confirm the D3cold path through testing.

I'll send v9 with the updated comment.

Thanks,
Jose Ignacio

