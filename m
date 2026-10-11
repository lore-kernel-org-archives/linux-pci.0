Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D601386555
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791705280; cv=none; b=ZrQofxFqVZyvXJa1p305rdADw/j9dXXpdBxjqdvGrkDgCoultKoYm9WPPolQYcQ/vS2pOUOTdwE9Z++C7l9LnmD2phKsksgjz9iuN5LIAVPnezb6PbsKnTkj8wLhb/CR+c5EUj3LJSSDzlkklLrmZUe8ZpodEYCeVoZ6Kb/UMwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791705280; c=relaxed/simple;
	bh=dEcJ/pFItgtT4/Uq84V4nCOcw5lFpC5TWp8hGwZydFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6Rgd3Urtb6MixvLWtnQuPQfDPIak8wwikdr7UFGt/R1TfsUB5oQGIP63bYr6Ysdc5pp1zS1WrNhE4tCyni+Z8XbY7EUyGTye4f67U6yVWLV7mKaVKahAUfQNgs9CGFEA01qvWlpPZIPyf7IJpOOsOXExqm9/P/dWhz1WunzNUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NoBKwz8E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoBKwz8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791705278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEcJ/pFItgtT4/Uq84V4nCOcw5lFpC5TWp8hGwZydFE=;
	b=NoBKwz8E7uJWTHakUeBw8v9p3gu5kQJoAwzJ0YZaSS4IiM4FmgA1bagx0EBdoLgXLDjKBM
	MADLvgb8u7NbWkzwDuxtV5oPjaqKIF1vI8XWA1ifi3L8rNr+hSz1elOiCkfs6TEk7vOY8P
	zInNgLfn9h3fZp5rsj9pRTPMAO8K7L8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-76GULbi8MJqa5ia54w_hFw-1; Sun,
 11 Oct 2026 07:54:33 +0000
X-MC-Unique: 76GULbi8MJqa5ia54w_hFw-1
X-Mimecast-MFC-AGG-ID: 76GULbi8MJqa5ia54w_hFw_1791705271
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C0F31800A7F;
	Sun, 11 Oct 2026 07:54:31 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4FEC8472;
	Sun, 11 Oct 2026 07:54:26 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jgg@ziepe.ca,
	alex@shazbot.org,
	bhelgaas@google.com,
	jjohnson@kernel.org
Cc: jtornosm@redhat.com,
	johannes@sipsolutions.net,
	mani@kernel.org,
	yishaih@nvidia.com,
	skolothumtho@nvidia.com,
	kevin.tian@intel.com,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Enable Qualcomm WiFi PCIe passthrough to VMs
Date: Sun, 11 Oct 2026 09:54:25 +0200
Message-ID: <20261011075425.516927-1-jtornosm@redhat.com>
In-Reply-To: <20260930140833.576941-1-jtornosm@redhat.com>
References: <20260930140833.576941-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Hi,

Since no further feedback was received after the last discussion,
I proceeded with v2 addressing review findings (Sashiko):
https://lore.kernel.org/all/20261011074514.515894-1-jtornosm@redhat.com/

I remain open to suggestions and happy to iterate further if needed
to get this acceptable.

Thanks

Best regards
Jose Ignacio

