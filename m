Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E9B2C1594
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778761874; cv=none; b=tloZEbXDlBtuXCrutlbTPNQzZPpvbOyHDdJZUBOT+xJC66jbHJ/uDtgU4maKsEtBYnlNAYVFBp580sLhVIXdnwhJclLxfW6CD5d97itwyOBCu0EOyJ0jJwSKiFpmAocW4B7hnq16h8qBbLVPps39QQwNfMx9ttOOacDcC4ExVj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778761874; c=relaxed/simple;
	bh=antehUrNf5IJasgfaifMhfXhrRMOJ/Xh7vw6qnbLd60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0g73bRbDGSKXIfQ/n1VrJs+5m20h5x9G4XverUr9OULsy92DOObE37junCfcRZGfcnfnU0SYeHdD73ajDMx/6a7Aa7+HQip7v+2/prgQOiZD0DpL13CwrnDhjUsiCV1bQHmnWugQqIcLqyYrYK04j34tsTcP53f7P01hf34tVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NYQhz5/q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYQhz5/q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778761872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bl09MvnW/ae8XD5Qv/hD405aLAzsWr+WDrJHmvEGprE=;
	b=NYQhz5/qJclsi3siwC/pS6TUlThDirRPlWRdrlOpN1k0MbLL84l8zJBv/sImSf/BnSzDv6
	LRQWd4yCbpKRDGFnrbvdnw3dQGZRvU5tooAVBF3c+ddskUANMuFGXfHGUoidYhkuAlSphT
	C6YMiJ7zU/v+OkB2Rn24VeUU/i38M8w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-vNsRx6K6Mh-6iWR0PwJYJA-1; Thu,
 14 May 2026 08:31:06 -0400
X-MC-Unique: vNsRx6K6Mh-6iWR0PwJYJA-1
X-Mimecast-MFC-AGG-ID: vNsRx6K6Mh-6iWR0PwJYJA_1778761865
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62E7119560AA;
	Thu, 14 May 2026 12:31:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.46])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A6AF19560A2;
	Thu, 14 May 2026 12:31:01 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: lukas@wunner.de
Cc: alex@shazbot.org,
	bhelgaas@google.com,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Add D3cold as general reset method
Date: Thu, 14 May 2026 14:30:58 +0200
Message-ID: <20260514123059.23829-1-jtornosm@redhat.com>
In-Reply-To: <agSNHLc_Sc_G-7vz@wunner.de>
References: <agSNHLc_Sc_G-7vz@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello Lukas,

> Why fall back to D3hot, even though the name of the reset method
> suggests it uses D3cold?  If D3cold isn't supported, I'd just not
> expose the new reset method.
Ok, the next version will include D3cold only if supported.

> I'd call it "powercycle" for clarity but that's just my preferred
> bikeshed color.
I don't have any preference, although we can understand clearer what
it is. If there are consensus, I am ok with powercycle.

> So I'd just return -ENOTTY here in the !pci_pr3_present() case
> and I'd do that for probe == 0 as well.
Ok, I am going to wait for Alex Williamson opinion for the other cases
but I will do this as you say in the next version.

Thanks

Best regards
José Ignacio

