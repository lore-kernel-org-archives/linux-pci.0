Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5A24FD299;
	Fri, 18 Sep 2026 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745855; cv=none; b=O6z7uT5wSBFgo1D8+80Gdng5HSvWr9LCHFXliCWYJx2OMV7IhWSV45u/fChO7epZmXOxylxrXYvG6BnlPkrIrbpe0c//1t7TqvUln3GNLuqnuVCv1dgizdvRCdTVHoKIMC1ywC5NFHiDtPXT35RZzOrSwf5QqRnJVZx2suscyPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745855; c=relaxed/simple;
	bh=wEvaTWXDvnJgQGalW3gY+IGZ+93Bir6HwzV0vX03rzQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=qPeali55N48bS30vToej2ip9A/p7dSzzyqqGQ3nXyy8aHzDnZigjE6JV8SYoyrrfdPm6Z0iZGbCMt6rQkzBjSQ1s8lx9KX7tiIghdZxPSws7DCW6/Y1AfqvTdbFzYZNhUAzp711jhLw5ezVLsayawNm1LUxETu8nBFd1lbnSAog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=pP9bWmdV; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="pP9bWmdV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=wEvaTWXDvnJgQGalW3gY+IGZ+93Bir6HwzV0vX03rzQ=; b=pP9bWmdVwu6S/Cv5qkol0IOUV7
	edF/1/n+x+87rzJZEbG7jq6JphNjfmT4qBTYfL+8d7/SW987wNIIfA1pzsgjsxNoJUWFAnicWlb6a
	hkwIv912wpBGXlARWqiWasUrBnd45bnXkmOo+3d6ejiGmy0y3kGN1O64Bm08JS8w16c9sQfBJ/ML2
	v3QV+EwEZ1XumxWDOx0CiGobr7RznFD95g2dQv3FxW02aHVWshoUcyqiS/ocIm+pBQJ2Z01EO50ou
	GDWgoh+nQnwE10eXL4o/QqpTecMF6YZyCfAF7HJkRpmqxqwn04ewTinqpPyAc6rU391nF65SVkBmo
	RP4k2fDQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1x7aeb-0000000CpQb-00EV;
	Fri, 18 Sep 2026 09:37:33 -0600
Message-ID: <94da5a00-c0b9-4cd3-b516-facadbee5097@deltatee.com>
Date: Fri, 18 Sep 2026 09:37:26 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Kelvin Cao <kelvin.cao@microchip.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Dave Jiang <dave.jiang@intel.com>, George Ge <george.ge@microchip.com>,
 Jaeyoung Chung <jjy600901@snu.ac.kr>
References: <20260902062153.31048-1-logang@deltatee.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260902062153.31048-1-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.li@nxp.com, kelvin.cao@microchip.com, linux@weissschuh.net, dave.jiang@intel.com, george.ge@microchip.com, jjy600901@snu.ac.kr
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v6 00/10] dmaengine: miscellaneous fixes for ioat,
 switchtec_dma and plx_dma
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)




Any update on when this might be merged? I thought it was ready to go
and I'd really like to see it in this cycle.

Thanks,

Logan

