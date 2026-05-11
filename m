Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24B0222565
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503186; cv=none; b=vFFW3oY0EFXVWKs5XzxJ/EEfcx8X6nKmFqDEHCMUO35aQsnMGKSVqassTgBYviAPztd2U0jpmqwk0rGZWz4YdanyPWpjnRUG/3IdxrJxD3sEg3i23f2GJg2zcmD1j3e1jQ8QXX5imnn8O0YfpI5u/mrK+2rvdQfUgUsi4Qkql5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503186; c=relaxed/simple;
	bh=UFxhVuW7PktYl7Z4nHne1a/r2at4I42QxVrHucXXlFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFiuK9AGGReowTDYfo++jSbLnAk6oAfEC8rqrlhDRmOyeInP4fycscr8+d9OByJlD8PT6fX5/oTTMKDsak3/eBl6oJQ7DR36RDV0q8rD132+fhIsJ3YzG0oqpdfjmP+h39vz7XC7WtAMyhuy53TlUknYEB5SN+LrhAq9ZN549kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QVzf8xqU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVzf8xqU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778503183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+uzeB2TWyHqeVEg3gXTWX+TcZGf/bfhh/rl7wHhoBc=;
	b=QVzf8xqUuIWFpYprWXgLtovx2pARKGR+qtAwL7KyqN4jYUm7tC/WFQLcdzzxjb07kz+2vg
	HBWrkYT/wzSl5HQkLLOTo70UTKJ+B3OOQuJTYbiaclSxf+8rz+N598b+krR2XYBSlpjBZj
	5d9bWou6mmmdAYGuO3uzRE1gFqvOkFQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-xmsCzfSUNRe6Uy79AIozUA-1; Mon,
 11 May 2026 08:39:40 -0400
X-MC-Unique: xmsCzfSUNRe6Uy79AIozUA-1
X-Mimecast-MFC-AGG-ID: xmsCzfSUNRe6Uy79AIozUA_1778503179
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52552195609F;
	Mon, 11 May 2026 12:39:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.142])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9ADBD18004A3;
	Mon, 11 May 2026 12:39:37 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: sashiko-bot@kernel.org
Cc: jtornosm@redhat.com,
	linux-pci@vger.kernel.org,
	sashiko@lists.linux.dev
Subject: Re: [PATCH v2] PCI: Disable broken FLR on MediaTek MT7925
Date: Mon, 11 May 2026 14:39:36 +0200
Message-ID: <20260511123936.36054-1-jtornosm@redhat.com>
In-Reply-To: <20260508212208.2544FC2BCB0@smtp.kernel.org>
References: <20260508212208.2544FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

While device ID 0x0717 is in the same MT7925 family and shares driver code,
I don't have hardware with that device ID to test whether it exhibits the
same broken FLR behavior.                                                                                                                                                                          

I prefer to be conservative and only add quirks for hardware that's been
tested and confirmed to need them. If users report the same VFIO passthrough
issue with 0x0717, it can be added in a follow-up patch.

