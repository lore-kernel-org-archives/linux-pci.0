Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CCC35C188
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116109; cv=none; b=WdrbSPNTdxuEY94KuPjPDejt2xDFRfcUqqjdtoWkPNvQU/ykZPPem6XdS90YRcc4wK4PbCVB+FZD46bglh3KS3O8dJYyMUvqG9ZkdeLj3Wc9lQQTaQIMlTc8fZENWW8Pi9FcztcFTSgQXYcGUTAJGRyf2PhWQtFSSv7IW8GQcjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116109; c=relaxed/simple;
	bh=9UFnAGYA40r/sjm4+73oibOIiWSY0H2QZyMR8VUTKVA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AlizqWt3m16gRLilR4q6LfqioawAdKhL3bEOi9rNleV5CmPRYUPIScsWahRwGJK1dJwKm22uPcIVqb+5xg0T1CC2LghLt5DI0lkIv8hFpalQHQ5FnwkoqivD5K7kaZgXNCF8fbHbxnqCiogCjLGVbUO/fq0ZbUkrw4vEMXMa9Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAakdwXB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAakdwXB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D771F00A3E;
	Fri,  7 Aug 2026 15:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116108;
	bh=9UFnAGYA40r/sjm4+73oibOIiWSY0H2QZyMR8VUTKVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PAakdwXBr+EzIwVBMmoGv+9NSvAVdVk7HecUQjwmAuVZvWYrhXaZ6NrPe9eRGbGlS
	 g2pTf+9UI3EPgb0MaBDbPiM4sGWWDgHXCbMT4bOgirUJXLXf2q0W014c1W40FaxFpO
	 G9AD3aDAUFK7guKKpT40n9js3y+GN7u3ojdiUPsqRJnrAVG6D9o07rR9Wy8Gxu6tzm
	 hceGjaTSMnhzKZjLRdy0lxUfBMDeRZsxAeyrUps/r1rzAhIpWKjJB227PgemIU81jL
	 IgBHnPlDGKkMURFltfK2hA3u1rnXZdpYL4dtpV1nW065CTg6ftwGPRL0292HPl4OQc
	 reMr+HMTnW/0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 10/14] i3c: master: Add helper to query bus wakeup
 requirements
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-pci@vger.kernel.org, linux-i3c@lists.infradead.org, Frank.Li@kernel.org
In-Reply-To: <20260807145638.168865-11-adrian.hunter@intel.com>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
 <20260807145638.168865-11-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:21:47 +0000
Message-Id: <20260807152147.C8D771F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add i3c_master_has_wakeup_enabled_devs(), which iterates over the devices
> on an I3C bus and reports whether any of them are enabled for system
> wakeup and have IBI enabled.
>=20
> Controller drivers can use this helper to determine whether wakeup
> support must remain available while the system is suspended.
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807145638.1688=
65-1-adrian.hunter@intel.com?part=3D10

