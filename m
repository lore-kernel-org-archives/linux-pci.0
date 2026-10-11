Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5801F09AD
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791702976; cv=none; b=car9piwsey3/qmh9pyuWZHSRJCP6lMfNUoA5pLNy+1ImtYs6AGRPGgIug2ZKSMNpvKkrZJczIau1aqouHU7WHMHzMHqOzoYIZ+O6WV28BzA0O3bjS5S5TtGlXwFy/L3rgqSiRRhwCQ1pF+V4e75u3Ws2fXEJJ/4jc2DWq4qxmBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791702976; c=relaxed/simple;
	bh=PzvB1EwVk3or1HqITSMtRhTjeLIcTgxEXoe1+Vds78c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osHlKhwBLvPvCFIKiNzPuI93fi6HIQs541wm591hx7XAN9uLJuJC/9t4G+5k5o/0EfI+L1FAfLhBHln6wnfAlOC0zc2bl0890Bo+2rdvqJHZM6km50ZMGRa0BvlliaHVeZv+rjejP4DEsR5F4yf6tYnr5hjIwOTLABN3wZP/8JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BuajmlSR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BuajmlSR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791702973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PzvB1EwVk3or1HqITSMtRhTjeLIcTgxEXoe1+Vds78c=;
	b=BuajmlSRqOP0ah3Ru5h1vxX8IHgSqoSale6IG6y+VMFz89UoMW8FBuSNtxJmHgykwJ7oSK
	Df8ULV1fSZm9RDg1cHTIjZQcO4Qx/im6zWCGGdGb46LZOqawjc3MKlOEwpllxcTuyktxHn
	44gPDi6gAo5T9opYwIT1lM2o8QrzBZI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-Uwdb19imN0-BjwPTsuoBQQ-1; Sun,
 11 Oct 2026 07:16:11 +0000
X-MC-Unique: Uwdb19imN0-BjwPTsuoBQQ-1
X-Mimecast-MFC-AGG-ID: Uwdb19imN0-BjwPTsuoBQQ_1791702970
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B19E1800611;
	Sun, 11 Oct 2026 07:16:10 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A415180034F;
	Sun, 11 Oct 2026 07:16:08 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: sashiko-bot@kernel.org
Cc: jtornosm@redhat.com,
	kvm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 1/7] PCI: Add pci_find_free_ext_cap_offset() helper
Date: Sun, 11 Oct 2026 09:16:06 +0200
Message-ID: <20261011071606.506908-1-jtornosm@redhat.com>
In-Reply-To: <20260930142127.9BE351F000FF@smtp.kernel.org>
References: <20260930142127.9BE351F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

> [Severity: High]
> Could this loop indefinitely if a malicious or buggy PCI device presents an
> extended capability chain where the next pointer points backwards or forms
> a cycle? It looks like this traversal lacks the Time-To-Live (TTL) limit
> that is present in other helpers like pci_find_next_ext_capability().

Added TTL matching pci_find_next_ext_capability() pattern to prevent
infinite loops on malformed capability chains.

> [Severity: High]
> Is a hardcoded 64 bytes always sufficient here? Some standard capabilities
> are larger than 64 bytes (for example, AER is 72 bytes, and VSEC/DVSEC can
> be up to 4KB). If the device's last extended capability exceeds 64 bytes,
> would this offset fall inside the bounds of the active capability and lead
> to data corruption when written?

Replaced the hardcoded 64-byte offset with zero-scan approach: walk the
capability chain to find the highest used position, then scan for
contiguous zeroed space. This correctly handles capabilities of any
size.

> [Severity: High]
> Can this subtraction result in an integer underflow?
>
> If the last capability starts near the end of the configuration space such
> that free_offset exceeds PCI_CFG_SPACE_EXP_SIZE (4096), the subtraction
> would yield a negative integer. Because size is a size_t, wouldn't the
> negative integer be implicitly promoted to a very large unsigned value,
> bypassing this capacity check and returning an out-of-bounds offset?

Fixed by using bounded loop iteration with explicit comparisons instead
of subtraction.

> [Severity: Medium]
> Because this offset is returned without reserving the space in the
> capability chain, could multiple callers receive the exact same offset?
> This stateless allocation appears like it might cause multiple subsystems
> or quirks to overwrite each other's data at the same offset.

The function now returns the first suitable zeroed region found, no
hardcoded assumptions about capability sizes. In practice, only one
caller (qcom-vfio-pci) uses this for a given device, so collisions
cannot occur.

Will send v2 with these fixes.

