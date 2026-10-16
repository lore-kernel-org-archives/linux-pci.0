Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD963769E6
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 05:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792128104; cv=none; b=snE6Mp1nwcPX5X3HcFFszIcVRzYLQKbGFEebuSNAsVLbpKQCMLl7IYXF95UtUFt9oCGavO7YlS3T4HPfBFxLzDyboYX/8Dy9T/AgaPheaLXWr5VJcU75M4xmkKzHDsHmG+sAJgvBxv+mD66h1Gmz55H3OSzLoA3zarjpi1XGV0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792128104; c=relaxed/simple;
	bh=lB5osmiHrjwXtkVduvX0rU7A0E/+8Og7oLLyoEI7DAU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=f6Wqn2gsylVUeD+awyGNG5766JBPEGorICRiqz71yKqZxhjUzq6ITe1l8NqfOXOROwCEFFu1FETVVvdxKUrrcCSudB8mM2LElrnip8s+8x//uN/KW2BqQ1yFQ1JPN9Ag6enLcs07LOxHN4xFrrY+rhcfyyQXXFOWfsEE23K3VYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXnJOij6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXnJOij6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D971F000C4;
	Fri, 16 Oct 2026 05:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792128103;
	bh=lB5osmiHrjwXtkVduvX0rU7A0E/+8Og7oLLyoEI7DAU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hXnJOij6MXPRUzDP0O/GlnIT9DoZgf1y+NMzDa6jkK6cRNP5hInz71oRit76HZCJL
	 aYlDF055du7IeiwDW9jel2O/5P73ekS5nFw+BZ0KuxuJzoCIMlALFCRUwb5fIkHtKr
	 NvUZ04q2eM3tVY8198Wt9hZurpXxLPYPyZ0Gt5+PrgC+anSpVEPUetxyjTl/1F47to
	 JvCIsW3MOkoRVPCmSSK6Oj8yTmd2IOWOPkcBIS7BZjRUphQtOM8xWUIAOCdZCti7XL
	 dRzfGm7r/sVBV7AY8shXDdBFBCXyZoyPKWm5HU/4STj72uphued3D4YhngllU6bFvG
	 Ub8NgJ9nRvkSA==
Message-ID: <sashiko-outbox-173817@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] power: sequencing: pcie-m2: Add Foxconn WCN7850
 subsystem PCI ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Val Packett" <val@packett.cool>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261016051745.577777-1-val@packett.cool>
References: <20261016051745.577777-1-val@packett.cool>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 05:21:43 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a new device match for the PCI subdev id found on the Dell
> Latitude 7455 laptop.
>=20
> Fixes: a39ac4651e3b ("power: sequencing: pcie-m2: Match WCN6855 and WCN78=
51 UART BT variants by subdevice ID")
> Signed-off-by: Val Packett <val@packett.cool>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016051745.5777=
77-1-val@packett.cool?part=3D1

