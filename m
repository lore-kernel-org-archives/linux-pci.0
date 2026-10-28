Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146150;
	b=Om22WxSmS3ytuG2bSYmvPYfDtV+KTM7UNMFyobgPbOa0XT2sfgBEV4TO/pLJ1HNCRy+N
	 vIllch+7evRNAqUBSn/uasCHEvA/1bYTjXwSdsRL8f8CDM64vOKIev7chOt+zeXMuSnob
	 rGTEdhifXf5afmLIu1tSDI2GeP0IPJULCMVcimXvr8n9Lnx/goLh3GuOPSVdyPsjO0BuC
	 DOQl0z5xF304pJlo8PpHryPrDVwR2hlNVCs3a3cYrwkL2fQ1XhetHLyTScnuBTAvOUGrT
	 rJcoIPu7GgxRR68AWzbPHjJRkOM2qMvIkD6T0OTb0NiPXoj9cny2DNLUNDJvpG8wsMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rYaht9shbFWxq4kumOpndSaFwe2UdArezXMn/5BLyPQ=;
	b=yOJASmLiuHRkzf28CuZ6kxBLmRRQoV3aYYQDF4xGBOj5JTwI+8zjkly7tz06DXcnER1M
	 C4k08Y9jZkOD50MzISabVsYT6fSwz6SVurfFU70AP11RIcYmjZiS72zmOHfzgXDu2E/EF
	 W+NxrxKzxFO5Q+JhtN7LAd2dQ4dvw+4Nm1lFBgPkUOugvKkWFZBzW/y9qeZQRtF0ksdqx
	 bMCFhk+m6MbqBw/HnxOocMVHjj5yhi7vC7pLEBLPi+FCL00gh8HmTsHQHNwVig2qIAGkW
	 zUHdD7R9VXtyOSMYwwkJwgu8xlfmdr0txk0ikULyKz6IBwHJ4hGZkIYxYmjNVJfWWmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c965U5rN;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D54606A320
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 00:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62D54606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c965U5rN
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso724077eec.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 17:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793146149; x=1793750949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rYaht9shbFWxq4kumOpndSaFwe2UdArezXMn/5BLyPQ=;
        b=c965U5rNBMbffOcZNVLX7SYC5p8jyV80hOEHtyvhV7AogFI+ESUuCFugBF5gwdEW20
         1fiy5dd03AVDB/cQe0C2Q/RBf0zXqKxCwbDPMYjT4MS2A3E0X5mvX49a6WCzw69f8hoA
         /AbRH0Zpauzco43FsFU+8YvGTT1N96yrAqTD/QS8XIuKhvU4b5Q/iseu+NQ+WaunolGn
         vFYPzzBjXIXCruLcSApWJMHiAO6IFXuZLuMhC9e7kIi3vz7n1XlfZ9tFjiF5Mnj5EJlS
         R0pxRi2kX9r75u0t+R7/97vtTf04NnYctSwuK8dRSx7xAlpU9SukX0TDQzOmpY4B4XM3
         QBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793146149; x=1793750949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rYaht9shbFWxq4kumOpndSaFwe2UdArezXMn/5BLyPQ=;
        b=AyJEi0eVGChpfzz5y97akvbgWlPWs8AnTP8Qrr+3L5pEAyyk8VNyBa+OQnppNbg6R9
         JSiuk3767f1Cc5am/hYhokzGcRPiE2zymqlPPTw8y/6le0NufDyMIzXeJgpjSRGOVOSj
         FGo1GaKRJW+/VIyJRtyESDEAamw5NYrjI3w3leOfO6ruWkoc4iOcksS6Vm2WtYA4RulV
         IvRpWHJGzJuwlFR+Rdw61DkvzBvjg4BKiS8t5PR+TG7nfFevlpArx3Dn8dP/N53ODQtg
         aC12UxfIJm2o10VdhimTpYsR2GjCkQ3dAP6Xp1LNW7bAh7vUCy1iKkgRO11QItBF3JB8
         x56Q==
X-Forwarded-Encrypted: i=1; AKwUvByMb5vjsU9JICmasIISHUlq0MwHluj9sOZ61PBCooBGau8q2U+lWJQLNarmF19J0el7ShrmOQToMHo=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7QC5axIhgcmH5bPJBPgzPp7oLm1HiIz8slZal1YSVzSy9Hcx+
	oAe6QZwfpFixUC8bOjE0YjfJwae1+GMFPAvQY6vSaT1pi+GCm9Mng2dYy9sA
X-Gm-Gg: AYBFou05i8mGWrW0ymFPx7LbvyR6WNj5NhIv7O0N/tyzhW2NjatwtjTiYnuiZVa5Ndr
	pwTQTebhxYZGJ/ZGc46ejfB0nquoDP9nMkb4gjNi2CAIJiaSvezcstFCALrjN4tTxIJNBD8+GzH
	xu94jt01pwgqcV5gf5bQ/9QOyPE2ww/ToCSUj4gcYJtoH6IwcvrZfqtW8dslfLLok821uwoLxrc
	ualq1fvpIFEL+nIsuRe1L07VxF0FilPbOHF0/HHEN8xlIh/LBMhPeA3S1VhGeLCz3x78qb4170Z
	LZOQoHQm/T+lcCl3skDeTVHDqCGaTK6j7bPnlD9Pld6xEPwBvHYXnfYG0hkedvMxL3y7K0+ZRJV
	AoOXgdYp/yz0A7zFOALYgqDctqyX+trTFwsnALHaA187GEssBkCvF8HV6LnlXoDPr+bNGPwKGyI
	NC3PmiBkNevhUhbq1LSLzgm3Pitq2IIB1v8CoqRNdbmmTUpwN4onkRtF4zuhInGZMyvCVCd9sHv
	JP0MjDsAAqljhNcpuZ0VzMtTPAuF9AraR2My3No4O5WOoSPUrRy7Mco4RArL9fp1reTe2zu3j1Q
	fLuhkeFIfltX+HL3Zw==
X-Received: by 2002:a05:7300:c7c3:b0:369:9af5:7bc9 with SMTP id 5a478bee46e88-36a2017929amr1084712eec.23.1793146149163;
        Tue, 27 Oct 2026 17:09:09 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.118.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239198c9sm336354eec.15.2026.10.27.17.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:09:08 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: helgaas@kernel.org
Cc: airlied@gmail.com,
	alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	christian.koenig@amd.com,
	dave.hansen@linux.intel.com,
	dev@deq.rocks,
	dri-devel@lists.freedesktop.org,
	hansg@kernel.org,
	harry.wentland@amd.com,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	kenneth.feng@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	mingo@redhat.com,
	platform-driver-x86@vger.kernel.org,
	simona@ffwll.ch,
	siqueira@igalia.com,
	sunpeng.li@amd.com,
	tglx@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 02/13] PCI: Disable pcie port and access on D3 on specific amd devices
Date: Tue, 27 Oct 2026 20:08:41 -0400
Message-ID: <20261028000841.6816-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027230042.GA516670@bhelgaas>
References: <20261027230042.GA516670@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Reading or writing to PCI devices in D3cold is a problem on every
> system and we should avoid it in generic ways.  I don't know what's
> special about these MacBooks.

I did not know about, i will try to remove the ignore_access code, and
will tell you the results, i added it as a failsafe

> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -688,7 +688,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
> >  	int type = pci_pcie_type(dev);
> >  	int status;
> >  
> > -	if (!pci_is_pcie(dev) ||
> > +	if (!pci_is_pcie(dev) || dev->no_pcie_port ||
> >  	    ((type != PCI_EXP_TYPE_ROOT_PORT) &&
> >  	     (type != PCI_EXP_TYPE_UPSTREAM) &&
> >  	     (type != PCI_EXP_TYPE_DOWNSTREAM) &&
> 
> Nor does this.  I don't know what the purpose of this is.

This is however nessacary, without this The CPU just catters, so something
used the PCIE address space or the config space of the bridges, unfortunately
dmesg dosent show anything or journalctl.

