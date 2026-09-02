Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8633C18B
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 06:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330938; cv=none; b=L1wZW3VNBu0h5+CO1iN4ocqwwifB+3z/u97GhY7kXa+Oh5Y10PYTG+N9/6haQkpj/MCet8J0PNej4WX+GUlnKdxrP0mtdl42jjZjc/AaJjWbobBv1x04CRpjeneUwr0/rYoRVwx/MqyFfnYtJmvZ0w/Sqyx841CD14Jep1cVj1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330938; c=relaxed/simple;
	bh=YwH9ABw/DM5LWNp+iWqHtTnGq3exluZ0De94TCsyzWw=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=Lw7s2PJoOlloMcngzM19DlyKw+Qe4YTdp+xBBghRGPO8+kdBUqwExNmwZckvE0MN6ep1xaFZBI8ridHqouea6wH2IG6wXD4gcOylbeUjjuGuhDNQR5hJphZyuh+mCjOW0N3MXN64PnD3+zw0KqsYVaucf2vXPemlrtb59YhybMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rCcqTu9k; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rCcqTu9k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1788330924; bh=YwH9ABw/DM5LWNp+iWqHtTnGq3exluZ0De94TCsyzWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=rCcqTu9kTh4ptTsY7yyn8b1oCi7U5TjYJsbKs2aOS2PMOjO0PzPAVhYymqVVutIfs
	 bqvQJo+xEfU00WG8MyH8/YqSfaHtxFsMnSMWTfNFaPjPa4WflL0iKNz7Z2SvCO7B9s
	 ZJE+QAOrbKS4J4AQTx8Ns/1Gn7h6l/E1rz2kkwyo=
Received: from localhost ([58.240.122.156])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 8D5AE878; Wed, 02 Sep 2026 14:35:21 +0800
X-QQ-mid: xmsmtpt1788330921tfwguak9h
Message-ID: <tencent_BD8B7DCB7F9C5B07D7EDF04E47DE1F41A208@qq.com>
X-QQ-XMAILINFO: MqswyhUqVe0C0RtcQUTbRaXR+/SrHTTmTaLeaKKyUG76GETP49CR7iM9aOyiYr
	 z/lHjInZ/qyrDzNHVbd+LPoea2AUlKHvWUTQeYElUSvxB4MLbk0XSlsJ7Sa/9czd3TI4J20Ru+YO
	 ScGs9Ji2fCX8CsIuunCIgcB4aaiuhpWVYrVUfiogvl9EB5tRupaFPo9NdfK5Jj3ahHB0m5BSRz72
	 GzU5/umsJMtqifR0iaHA10oePvH5gmHtKDWhkaytzrPHa/1HXnSuVLSmc67HyqOY713XqTXLwdfq
	 JynDa+P5UnWYx8DlN9GGHqXcMe3m6utGeTvmW498c1/gmSSYHHCwsQXA+WWq7TAzhZcj8xyaeXc+
	 rMGJNCHHY1wm9zNj4BmEyPAi1mGKfrJAkmx0iDcl2lAHany4i4DDkriGftMRefUN4BvFwOg1qLBW
	 +M0/YcwlOrHt8/MZJqlv9jFbWgWCjP+vclwWpXSJm4gsyziXivaHxCrR3YwJljYuuqll/TK7GKJS
	 YwYVKXtMD6Zw6c43drrFQFlHJBaNa84wULKaBK4if5gk3cHmu6su5Lm7cs9nmQRI9qr2ZFOa6bWg
	 yOH7D5TYkw1qGAOyftoDp/GyDgGb2xUNXdRa/N3kPzYq79GNvJgEsbwjxVn1WoDF4QSL96j+03Ga
	 4Bkc4dDWGZ6JklNPjSvsngHsSr85+CSz1gC1RIjdAWbS5tUPf/ORaO4RLx4lMC6eFCQu2HgEDHwm
	 WQh//+zqYpQJ5YcIB5eQK7cQLVpSpJ8hdY0ZSV2wX8rIeTYP+uRmMNXbs3sza5sHt79Qz6Gxup+Q
	 6qFU/sYhVv/duQg8m/kbh29CWd+32dVr5vcXOmOzZT5HwGq+BpVzQkG8ZtEb31KcSa9Ys9vf8MFB
	 UaHJe+egqpLn32gIT6HrhCzxzLh5AtX6NoIZrPDktpPHEHAiM7oKJFJLZfiC7paMfs94qMikIQVh
	 eumCxbdJXJGgU0BgA9hwuuL9kQympreXAte8PGIeOzsWNBFL6GxEs/B7hTeP7pt9ckLt/iIN4u5J
	 Sda3pdG3wdHN7l8o02XB9oKvRRgsON1aIfZQ21BMHWIuy3qfSOs2B6CCp6u0lT1Ec6DfeB4Q==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
Date: Wed, 2 Sep 2026 14:35:21 +0800
From: Zhengping Zhang <aquapinn@qq.com>
To: ryder.lee@mediatek.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	zhengping.zhang@airoha.com, lei.dong@airoha.com, hui.ma@airoha.com,
	upstream@airoha.com
Subject: Re: [PATCH] PCI: mediatek: Find INTx controller by property
X-OQ-MSGID: <apfDqZZJv7PN8cBu@PC24010019>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_5E7D6E7FB25B4CD732F08547C11F5DA24808@qq.com>
References: <tencent_5E7D6E7FB25B4CD732F08547C11F5DA24808@qq.com>

Hi all,

Gentle ping on this patch:

[PATCH] PCI: mediatek: Find INTx controller by property

This patch has been pending since August 5. Could a maintainer or
reviewer please take a look when you have time?

Thanks,
Zhengping

