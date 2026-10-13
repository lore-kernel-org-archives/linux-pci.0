Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED1C51118D
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897383; cv=none; b=OVebCNTvBnMEvkPGVUd3k8ZEmvfzaUFZtFYyd/wloc3ljg2BozWshGUuHzLLyriQE6zsVdHhZG80HZ1+dnpC1yqzWc2eXQVF3gN2reFb4zOVYzFku8LPbUxxxsErbXmAKbNSbe3Tneu5tq5nS2nvYnsTRxvGBCw6ro2JYGHRhNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897383; c=relaxed/simple;
	bh=odv+k7DjqenX6xxz7zG9JRUOB4R8mu4XgSWXiWB2KJw=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=DeaPUZBXs7HNkpLlWU61YXXX+rQyYj92JPelRarp7qbjYwHz5MXMUpOtDsOG5k4po2W0RUOIGJiQkGqWZ9umhs39/Kx8C0xOM24lC3pt+9GN6PydmpLntN4cbYn+eFHnVDq1pTi7b5nWkTRa/+zgN4KcCs3Pm7sQHuSyf+loqkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WELvh5xJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WELvh5xJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F661F00898;
	Tue, 13 Oct 2026 13:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897382;
	bh=odv+k7DjqenX6xxz7zG9JRUOB4R8mu4XgSWXiWB2KJw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=WELvh5xJsl2HB9r1WbsCpnicI3bLaesBVg1R/mzad35JhA6hzZJNexsy2YkT/hGxS
	 1e31HTfG3iMktaHbHwD7tiySotQbqS5cTWzvzGPBtP5RKavN6lJm20BUhOYyBF6hEl
	 qFIFzghnEBL2h7hPVZjFsAWOlHdOnVCVxZxv8AWCjlvI1wWhtpE9yjrRQR2GWnASG0
	 MNlRGsDc/KRXRuGfLkI0VjH+IqkjhrTBFub9EhbSz4x10wrTjnjsd+qiGSp7qOccSl
	 C4GqS2eU9hmJVelZ+YXHnq8T35cYFRUdXV1pfQrIPbv8LObPNeMs6AVKGH/sMiTuJz
	 UEdW/ebwybx4Q==
Message-ID: <sashiko-outbox-169789@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] linux/log2.h: Add 64-bit
 roundup/down_pow_of_two64() variants
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261013130948.6231-6-ilpo.jarvinen@linux.intel.com>
References: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
 <20261013130948.6231-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:16:22 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] log2: 64-bit roundup/down_pow_of_two64() truncates and UBs on 32-b=
it archs
--

commit 56bd761df1693290739ce316beb7a19a30f72c63
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
linux/log2.h: Add 64-bit roundup/down_pow_of_two64() variants

This commit introduces new 64-bit variants of the power-of-two rounding
functions and macros to prevent unexpected truncation of 64-bit inputs
that occurs with the existing helpers.

[Severity: High]
In include/linux/log2.h, the newly added 64-bit functions
__roundup_pow_of_two64 at line 69, __rounddown_pow_of_two64 at line 89,
and their macro equivalents roundup_pow_of_two64 at line 198 and
rounddown_pow_of_two64 at line 231 all use 1UL as the base for their bit
shift operations.

Since these functions and macros are explicitly designed to process u64
values, can this cause undefined behavior and truncation on 32-bit
architectures?

On platforms where sizeof(unsigned long) is 4, shifting 1UL by 32 or
greater will result in undefined behavior, and the upper 32 bits will be
truncated before the result is promoted to u64.

Would it be safer to use 1ULL as the shift base to ensure correct 64-bit
math across all architectures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013130948.6231=
-1-ilpo.jarvinen@linux.intel.com?part=3D5
