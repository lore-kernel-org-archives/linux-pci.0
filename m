Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8B1149C7B;
	Sat,  5 Sep 2026 00:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788567281; cv=none; b=ef8w317qnbhnzf9KtZgslfHzAakhINRfPIaEsc+6q692Mf4FRZPkwyISKsVY0EPiYgcOrbR25MeEVAVlu1qvHaViIFork4mhn3/eSCdx54QhHnikIjN8BS/QrnpHMu3QMMdH+ki46Q4NQTYngbekhcovd0evaJXf4VciuBqM7k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788567281; c=relaxed/simple;
	bh=wWR8pYwRnbIwhtFemee8DOhqwiuz2My61ujFGXhk4BQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fq/Lx0TWOtz0ZTjbBjXXby215nVRbJza2sUQoxc0gcikHhoh/gKzmJPdcyIIaykV2gBPP5ZszSyBukvYtXQi11iz8SiigEBrZapoHNT1ULhHy94kcexHGrmMNoa5kcO7xBdULugKuPTgP9Zudgz/a3ilttgYr1YJacmuCqOZC1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iutA9IcQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iutA9IcQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229131F00A3D;
	Sat,  5 Sep 2026 00:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788567279;
	bh=TLURiP4J/erwUhCITNFDdR6GizrdBUQN5HLBgspG3SY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iutA9IcQ8Kb1YwbQEjSl60sYOPT3swzfyas+U+uI9T6gtRUun6/Qisi2uFCPXTapx
	 cBegS+yZeeQ6PS5LORJFzZEx8ZvoV9wayXzjkAM7PmnSeaiAI8riZKD+FFlyF8yyZl
	 nmYU/z9nML4Wl4Y8kJ/2qfOX/BhIHeFklzsU6Ra6htkxMZHfyK4kV9856du6pLkNI2
	 N6E8iQnwGVr8RThz8XvHG0F+cRwdNTCyN/Gf1X7/Zf0QFbD7Bw5La5ZJW0C71Uc1CB
	 NQCufcvFrEBQNbfQueE166VjkYk2OzdPrNTLdq9Z1X8LmqU7W8n8OnKsB0tw2CQSVm
	 tjDrQtD0nUe6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] Kconfig: fix typos in core makefiles/code and purge
 remaining ghosts (v3)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: media-ci@linuxtv.org, linux-clk@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20260905000655.103429-1-breno3011alves@gmail.com>
References: <20260905000655.103429-1-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 00:14:38 +0000
Message-Id: <20260905001439.229131F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The patch completely fails to include the changes described in t=
he commit message. The intended C, Makefile, and Kconfig changes were not s=
taged.
- [Low] The deletion of `lcd-panel-cgram.rst` leaves dangling file referenc=
es in the MAINTAINERS file and translation indexes, which will break mainta=
iner scripts and documentation builds.
- [Low] The deleted documentation file describes features for an active dri=
ver and should not have been removed as 'ghost weight'.
--

commit ffbb32c7781c62294c55f80e85430c46b71f5e34
Author: Breno Rodrigues Alves <breno3011alves@gmail.com>

Kconfig: fix typos in core makefiles/code and purge remaining ghosts (v3)

This patch intends to correct various typos in Makefiles and C code, clean =
up
Kconfig files, and remove remaining ghost weight. It modifies the admin-gui=
de
index and removes the lcd-panel-cgram documentation.

>     This patch:
>       - Fixes MediaTek interconnect typo mapping mt8196.o to MT8195.
>       - Fixes MediaTek regulator typo mapping mt6316-regulator to MT6315.
>       - Fixes missing CONFIG_ prefix on DVB_ULE_DEBUG macro in dvb_net.c.
>       - Retains critical PCI_IMX6_EP and Tegra audio prompts to keep hidd=
en
>         symbols selectable.
>       - Cleans up the dangling comment in drivers/leds/Kconfig.
>       - Purges the remaining verified ghost weight.

[Severity: Medium]
Did the actual code changes get omitted from this patch?=20

The diff only touches documentation files (index.rst and lcd-panel-cgram.rs=
t),
and none of the mentioned Makefile, C, or Kconfig modifications are present
in the staged changes.

> diff --git a/Documentation/admin-guide/lcd-panel-cgram.rst b/Documentatio=
n/admin-guide/lcd-panel-cgram.rst
> deleted file mode 100644
> index a3eb00c62f532..0000000000000
> --- a/Documentation/admin-guide/lcd-panel-cgram.rst
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -Parallel port LCD/Keypad Panel support
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[Severity: Low]
Does this file describe features for an active driver rather than ghost
weight?=20

The documentation appears to describe the active parallel LCD and keypad pa=
nel
driver located in drivers/auxdisplay/panel.c.=20

Should this documentation be retained?

[Severity: Low]
Does removing this documentation leave dangling references elsewhere in the
tree?=20

The MAINTAINERS file still lists this file under the PARALLEL LCD/KEYPAD
PANEL DRIVER section, which will cause maintainer script failures.

Additionally, there are still references to lcd-panel-cgram in the translat=
ion
indexes under Documentation/translations/zh_CN/admin-guide/index.rst and
Documentation/translations/zh_TW/admin-guide/index.rst.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905000655.1034=
29-1-breno3011alves@gmail.com?part=3D1
