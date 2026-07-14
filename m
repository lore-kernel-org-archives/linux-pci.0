Received: from ns1.suksangroup.com (ns1.suksangroup.com [103.13.31.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445132D8DCA
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 05:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.13.31.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005639; cv=none; b=k7Jn+KG5zPZ/UZanPY4geeQSB/gIfrp7iy9QVYZUE0fqGHoROHn9KloY+qRar39bZK1/L0+2139VpH2C33y0K7836cnTS+nhXiLGhNib9i7swZX7+kEfvdpjPyH5DenwOgqIrrXKS+ed694EVT0j1X5t5sGX+lbYPfRvrZXkA8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005639; c=relaxed/simple;
	bh=5rqMP/Ssyd3roMoTbDhFgkrb+oryLk/j07RAKnkbVoU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BNckmj6Xr2YU0VYwThAZ6Eb0nZPAYAxR2WcN8Avrhg4nah04ZfMHF99/uTBxbS0dVyJ/74+NU7LZattYCmPnojNj+RtHTtosxXeKAYfTIr1mC0w/ElFENbkDDCx2MpnlnFV5XyR9H3InurON8/kKKg6wbHgouHrzSh/eYofE+eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org; spf=fail smtp.mailfrom=inbox.org; dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b=rIqAZBBq; arc=none smtp.client-ip=103.13.31.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=inbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b="rIqAZBBq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=suksangroup.co.th; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5rqMP/Ssyd3roMoTbDhFgkrb+oryLk/j07RAKnkbVoU=; b=rIqAZBBqP59Opnpdo1WaAqAwjB
	ttGNQVoxUAcOLTwobltatNhHz2IkwpfJ6DsZr8hUjB4vk+adzHZH0ELQwQuzMGf0dJxKZRZnYRm+D
	SapTaAt0LPhGHLvHmjpjPQwVRr9yN2VL6lWEJ97K6nO27+DEP/fykk+kfZBa4mCfe2/KDNXYkBvV3
	Jsj4vo9r2lIyOdefmpwG7d99lAyZAnKVs24oxMFscUqTFvO8rReYWGZMgA0WENPtT0ukBEh6hQvBg
	iFa2AnCd0tAmtYPIIkY3iCnKyDzQYWyhIcL7T6VZko4+Se889Ld7f3IRrqstA6q67Xo2H6MM6bvyg
	f8tDxbCQ==;
Received: from [207.189.26.187] (port=58264)
	by ns1.suksangroup.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <info@inbox.org>)
	id 1wjVMR-0000000Flxd-2bTw
	for linux-pci@vger.kernel.org;
	Tue, 14 Jul 2026 12:07:14 +0700
Reply-To: hanns.schofield@lexcapitalgrowth.com
From: Harry Schofield ESQ <info@inbox.org>
To: linux-pci@vger.kernel.org
Subject: Dear linux-pci@vger.kernel.org, 
Date: 14 Jul 2026 00:07:11 -0500
Message-ID: <20260714000711.B2244C26479B57C1@inbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns1.suksangroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - inbox.org
X-Get-Message-Sender-Via: ns1.suksangroup.com: authenticated_id: smtp@suksangroup.co.th
X-Authenticated-Sender: ns1.suksangroup.com: smtp@suksangroup.co.th
X-Source: 
X-Source-Args: 
X-Source-Dir: 


Re:Good day linux-pci,

Please let me know if this is best email to send you the project=20
info.

Kind regards,

Harry Schofield, ceMBA


