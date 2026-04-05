Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6128D28AB0B
	for <linux-pci@vger.kernel.org>; Sun,  5 Apr 2026 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775417398; cv=none; b=CAjhSmvkp+FlFEaHKT3h+y2BjuZ6Wo9lFCsVZOW0ec9Xys/+wJd29xWVUy6p/kpFv5RX+EuWuKsecCJIefSsZXq8Kmsjx6q/HVtOv8zcIrut7EHvr6uQ2Xm2UoBGFCM54qwP2/YctfY0GvyA1ARz2ScBz4anMewzfp70UdT384Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775417398; c=relaxed/simple;
	bh=kjBgt9UVCJEfLfun7AE1eFdlAHMpqnnpiOlHfdnJPgI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Va603tEm2WXqq78JPFFp/RO1ykBjZhdvBS4eRHSQ2RUJRK1X+2NUOeopG+o4161Z/W1G0v8SfATzNjunOuUoiDN9++jlw5qIm/byy20HEeX5w8emJvcktNEuc9MbkA0Kg7mPVzxQ0CVUTWjDWBxEcHTAeRzcTfnUVPViQz/EkGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=WxYzSgvW; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="WxYzSgvW"
Received: from albireo.ucw.cz (albireo.ucw.cz [91.219.245.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: smtp-albireo)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 24D24327ED2
	for <linux-pci@vger.kernel.org>; Sun, 05 Apr 2026 21:29:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1775417393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pMBNMRQYSRhD16XNrlEZ9eTNnEu+8SysLEAtzBHXSp8=;
	b=WxYzSgvWAs7CC2S8z50AK38Muv/fakSxDnVPOm0e/bE6S5drW7IRfiQaGNHS+O+0RtyCyb
	FZrSOEZXTytSGdOewCtJPPIYbYJEJgkUSp1BB5hjhOHRj2avZDpEazbF8cKWrJiivsD5dq
	Tf875fDyxLW+08qrVov/jeeicqUpa84=
Received: by albireo.ucw.cz (Postfix, from userid 1000)
	id EF061AC12F3; Sun, 05 Apr 2026 21:29:52 +0200 (CEST)
Date: Sun, 5 Apr 2026 21:29:52 +0200
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: pciutils-3.15.0
Message-ID: <mj+md-20260405.192925.31574.albireo@ucw.cz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello, world!\n

I just released pciutils-3.15.0.

From the ChangeLog:

	* Released as 3.15.0.

	* New capabilities are decoded: MMIO Register Block Locator,
	  Flit Error Injection, Flit Logging.

	* Decoding of PCIe capabilities updated to Gen7.

	* Both lspci and setpci warn when the "-s" or "-d" option
	  is given multiple times.

	* Improved display of interrupts in "lspci -vv". Routing of
	  interrupt pins is shown only if the pins are not disabled.
	  Routing of MSI(X) interrupts is shown when available
	  (which is currently supported by the sysfs back-end only).

	* Minor improvements to Windows back-ends.

	* The dump back-end can read the dump from stdin when given "-"
	  as a file name.

	* FreeBSD supports 64-bit addresses.

	* Added README.DJGPP.

	* Updated pci.ids.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
