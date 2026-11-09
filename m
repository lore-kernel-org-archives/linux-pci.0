Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794200077;
	b=CZ0X8SgPO9Y0xa+IOngCBbYIMMROnkQyfirmp6Xs+ScyKl+FWRySl7Fe11eVi1AbgNrr
	 uE7ZQiAay0hVH9wXPNEkSU8xR3Eex5s5iiPmJUMHyCL5kGLExWOHT6YomWde2VQ2W2nrX
	 bwwphIRXuFHKEB2UlenZyCIlReBJp39qBT8J58fehjlPQMZP8iOxYHhmmt2vFeHcBe8Ot
	 E/LDDm4CgxrgeMzrFQ3s8WqLc77PoRIQTqGXFBx4kMpJiElQdi/ScPCNEi2aMeb7myCB4
	 /PHQPjcn+3HwbGvH3hbhFC83UUKRZU3M1FADOf0dronoAJx+TdxBbz0KBulMs7jGVQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200077;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HxOJjxxAA23BtFl1yH0m4TU0F4sP/+f5RvSh1fFL9Xs=;
	b=Dxk+hWqyDxBkjIJDgYrxyQSve583NF4n0Hc+PUjc/y6W12tOLr2TxJ2wy7j8fiOD7ooI
	 4rNHco4KHK4O1IFc7vRFJL8oKr+zXHZTKivcQSmqbgr0lI1uR/0o1yXnOKQPub7idtf1y
	 YtyxHITMkL5H4uv3a5RAEAk5lQywca6mPpJK9TWeW/tslsi7BnnyRMtsbG9hgM9yXeMNv
	 z2cv/FLHW9dhaiiZcO6lpyxV9I7J3GtfxdHho775U6Mup6f/Zdk7rcGR/obebn7o3baEB
	 FcpEf+bMMEUeKyC6tCdvr9y2YOAYBkLwHm5SlEI+TtQyu6X1KMbonyzauGcseU9g9KA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=XW5fo6x3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.17
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32FA606A321;
	Mon,  9 Nov 2026 04:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B32FA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=XW5fo6x3
ARC-Seal: i=1; a=rsa-sha256; t=1794200057; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=MCasi0aAC9bQykT/uLdFVStj0hkr8DzDDISEPG6FQROiPLiTiT0qTGFWVu4S3dsCG2W0sa8JHCrdah56whz0XsrK0vbjHf+QLF0EKaDsK58NpZSYGBN8W+Rio0zq5QaOlXJTr68+gL1iQ2BGfqwZz9I9kO+gS4X1ueYpdguG190=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1794200057; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HxOJjxxAA23BtFl1yH0m4TU0F4sP/+f5RvSh1fFL9Xs=; 
	b=CuWLGxie1s5DGDEQTCalGFFmxK0L3ZNj7synKfPmsUjRO9V8aZrzr1q+wX2UokqAwQCqcmZ6IXOHy3IWD2nlMq9kWYXL98rGfqOm0AbOlfFfTk41xSXFr3Jy0VbEzCAA4IJG9DNg9oysGp61GNhkrY5c+XtTJLH1CqgPV8pQcdY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=XW5fo6x3E8JPX8znOqWTAOZ3H4QDP0NRlEwogfmmxYsPl/dDG+DXOD7PgBxvZbN91y9/oL+dZvK4JlNJscXYUrCRVCYBIi8usvKHQs1wPjppTnnWXmohbPw6QC3RmtQvb3i/5LMcIsxEnRUO025ElUgJvX1qiXU8P4RBNwrf5fQ=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=HxOJjxxAA23BtFl1yH0m4TU0F4sP/+f5RvSh1fFL9Xs=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 179420005643772.08283895890384;
	Mon, 9 Nov 2026 05:54:16 +0100 (CET)
Date: Mon, 09 Nov 2026 06:54:15 +0200
From: Igor Velkov <iav@iav.lv>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Enrique Hernández Bello <ehbello@gmail.com>, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com, robh@kernel.org, heiko@sntech.de, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH RFC 0/2] PCI: rockchip-host: Retry training and hot-reset a JMB585 on RK3399
Message-ID: <20261109-rockchip-pcie-tx-swing-result-1@iav.lv>
In-Reply-To: <60fbb95c-63cc-4d22-9e2b-51332a50054d@rock-chips.com>
References: <20261024-rockchip-pcie-resume-v1-0-58e54a5cf5f1@iav.lv> <20261109-rockchip-pcie-deskew-result-1@iav.lv> <60fbb95c-63cc-4d22-9e2b-51332a50054d@rock-chips.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Shawn,

Thanks, that settles it. Bad bring-ups with TX_SWING_COMP against the default:

  0x4: 10/104 and 7/104, default 3/104 and 6/104
  0xc: 6/104, default 5/104

I did not measure VDD09. I stop looking for the cause here.

Next: I withdraw this RFC. The hot reset in patch 2 does not help: the link
comes back fast and still aborts. I will test a replacement on mainline and
post it as a new series: watch the LTSSM for 5 ms after link-up, and bring the
port up again if it keeps entering Recovery or training timed out outside
Detect. In Armbian that gave 0 aborts in 600 rebinds, against 5 in 150 without
it. Nothing needed from you for now.

Igor
