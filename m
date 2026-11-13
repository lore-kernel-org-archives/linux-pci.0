Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578594;
	b=JFxlROf++oHWQIqeTWdH2MiVvVvXRkUFG/XXq7rBO5LDB7DrXHE6QSB5EE+IGtyVtY2b
	 29xKTjhbJcFZJOxaMe50oqwfAAFWV9HzRGbTN5jeVJOIeCqWvDpOFmUXcS7EJUo/37+2b
	 tJ5TcUXIJl7DD3Un5gWaqd/C+y8BO6WRxRXDJ0OqWBz2eDwBHdFD6AmaxNHekZKhOPBbm
	 ndOEO1YyKMlhqXAAcKgFOfig4BRhiLiVWo4WkP1Y7Ro8UksADIRhUj9o+J98Oxc3S1pkD
	 A1y5AJVPd7IYuOwTdd39cpXjCbVnnFhXkEfKrRMskUUKOSl/sJFxH+mIiHDvkcAgNnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578594;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DFuB08qAjAmslitRzuOhPdQT8P6OGLNv/tiN8ZDoYJw=;
	b=eMXsgOP8+eZzV/KVcJ72Un7SuU+76jvc+nO7hzUyK2XiAjUIu2LJY30DBCfGlEyNElrv
	 X/SOXpU7WiXwN+UqTPGmCeSWstomw+20EJyXVXigiST8zrbQzNTULIlLu07M2K/x2IVL+
	 qGatNxoBq/QZXJbiG6oDtTo4erA5kO5dt5uTbq2tOaeZLV59xq/I/d9eteaSLMcI0RmcJ
	 FbWO/+O4iH7OkcolCvajiNw5etq39lwfq3jIsbDAgh0Ped9GEqvbC6qnY6W7oTBIn/Zod
	 zPutleEiNeKCd4RXU0rqljGly2yOOK3DvMOjN53toF2PQ0OFhal6ABEJ41FJyvJnGEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGc8W0oz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BC8606A884
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGc8W0oz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95BA1F000C4;
	Fri, 13 Nov 2026 14:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794578594;
	bh=DFuB08qAjAmslitRzuOhPdQT8P6OGLNv/tiN8ZDoYJw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HGc8W0oz31P8PTChXh0AMSgPQVGqKA0F1jzJ995FnPsfDieC1AMtfA/lxemNd0s06
	 mwbu5h9CV+XiUEPXHfenjrDeum61j+B0k+JRebWtN8bbnRfi4/QPsWkaEOEUEGDyd4
	 aSDgVf+yL3u7Lq9IsN1hgEvhki6yPfHV9HJMncSH4nrahCwc9V8OyX5TJc/gTHj2i7
	 rBgPDv9aTWZeQGwlxETX8s1G5JZXF4eW9acDpizcoYMTxmIw5ba75D9dvwfBt+Ncf6
	 qEbXgOtdA6IgydvPvus8G99boMWVMrziMb/cI9XyEANtwkGkij72d4kCqTN1PY0tK+
	 /rskQq4T1+quA==
Message-ID: <sashiko-outbox-212952@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 07/10] Documentation: PCI: endpoint: Document vNTB
 DMA export
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261113132935.4152566-8-den@valinux.co.jp>
References: <20261113132935.4152566-1-den@valinux.co.jp>
 <20261113132935.4152566-8-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:03:13 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Document the dma_bar attribute and the requirements for exporting
> endpoint DMA channels. Also document how the selected BAR may be shared
> with an MW.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113132935.4152=
566-1-den@valinux.co.jp?part=3D7

