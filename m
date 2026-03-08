Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020F930AACB;
	Sun,  8 Mar 2026 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772995262; cv=none; b=HYnBGHKS+lQ4Nh1imHQlJD0ZZ6nx3OnRYkifMyfD3LyWy/2vuH7dTVlL1tmbn0I889Cx3KIR+SMi34MbXng+Cl8J2XkvTrS870cBS8XIfduMKsAmJwffxSVkbhA8U9cvQpIpo/ZyhzlS32ZJfcl48GowB2TYibn6wy5BlCm9kkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772995262; c=relaxed/simple;
	bh=ZclR3MgADbuk8gJW1YDMUHbgzO8DIPC3p7HfmBQ2uv0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PgxHPiKsBanMGjkCgr5ygkGLjCp6Ccvt7qyGpv7IBnYvGZAydaT6kuIz5cs+WzxC1FNshwdEcU88HPRZB1R4ovx66h+q2jpDAdCJCV2zS5lYBmXOTD9Kd6yiIxts/MJQB3DUQO/ixxGLK+jbtSnIvtr43TAv3TTnZu3hnYmE/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id D43C38CD9E;
	Sun,  8 Mar 2026 18:40:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 6CBA920025;
	Sun,  8 Mar 2026 18:40:45 +0000 (UTC)
Message-ID: <ca170cbaf2f8bcbc89bbda68914d8e0d7640f0e7.camel@perches.com>
Subject: Re: [PATCH v2 phy-next 24/24] MAINTAINERS: add regexes for linux-phy
From: Joe Perches <joe@perches.com>
To: vladimir.oltean@nxp.com, linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, 	dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, 	linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, 	linux-can@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, 	spacemit@lists.linux.dev,
 UNGLinuxDriver@microchip.com
Date: Sun, 08 Mar 2026 11:40:44 -0700
In-Reply-To: <20260308114009.2546587-25-vladimir.oltean@nxp.com>
References: <20260308114009.2546587-1-vladimir.oltean@nxp.com>
	 <20260308114009.2546587-25-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: mibobo4wkbramau4qyjthmehkiqudojz
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 6CBA920025
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/1oqpGv8s8V8RuGZRFC80nZh9ljOj3ohI=
X-HE-Tag: 1772995245-174125
X-HE-Meta: U2FsdGVkX1+4XRzz60ugpVFQWsQctyjPh9D8dWNkk9O80wKikqTLI//fEpSwY7VKkjTAQqCbvy/bDztttYzuNBQP3PDd6DE18CINvDdnHew5cXtwNDDJn4KiBH3EXroYIs/0V5C/aytRQmLMTGCZZlkmVqa0mog1lMlvYoTUOPxP3MIGj9+OItuBdGt7SwG+E1NN8A/Yc9Sq4U8TJPe/XcW25BuE6rH2bXBjLakvy2b4imYLaL6YRBqKlFvDSAukFbzkOlERn3vJJPcvYBJiMotKjWx2PYK5v4pDPHYsRlN9R//2k7hsjvl6B3t7ELpdAjuD6CN+C7OKO7KQLV3bHimDBNhwcxGB9M1yVBNLk9v9/I7LPCcJRUT7SR2W+eai

On Sun, 2026-03-08 at 13:40 +0200, vladimir.oltean@nxp.com wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -10713,6 +10713,17 @@ F:	Documentation/devicetree/bindings/phy/
> +K:	(?:linux/phy/phy\.h|phy-props\.h|phy-provider\.h)

phy-props.h and phy-provider.h don't seem to exist.
Are these going to be added later?
Maybe this should be phy-common-props.h ?

Perhaps if matching only the include uses:
(/ is escaped because get_maintainer is stupid)
something like:

K:	include\s*\<linux\/phy\/phy(?:-common-props|-provider)?\.h\>
