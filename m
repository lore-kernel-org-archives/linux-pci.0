Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7412BDC0F;
	Thu, 27 Aug 2026 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787840056; cv=none; b=L0F4vmtSPsEbLwK7ptsyowKur7NG3SOhKObxgK/jcRzMbf6NvAUN46+hZj9XXbbZNT0K2UmZgZIgC26uSYdBzVO8zX/Fx3IEfr+JIU/UzJ3ki8uQIHYUaQAmJmItq+JpDHIE1dzmtBsWLs8UCC/ue5M+KRGg2w1J5ysMrI9eKmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787840056; c=relaxed/simple;
	bh=RGBJ7wtnojeigFfDstXivL/2WwfcNSG3htWo942iK2U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hcdp6ORR0tGixqO2vEIKQpt4F4ooHA7NfTHad1vb26jRMGhRITlXKc7GcX3HPHeUHhd5iSYPO2J9tJXG+U12bqokciMgUIckKkSFsOTBBjFGzIFVdeqggYdJTSRmgPzN5+M9lpZb5lJrgiovcK/jCBD/pGk5nuqNDHelxil5L6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3YVsEci; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3YVsEci"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C531F000E9;
	Thu, 27 Aug 2026 14:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787840048;
	bh=RGBJ7wtnojeigFfDstXivL/2WwfcNSG3htWo942iK2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F3YVsEci65L3rPzHAm5FE8R9NtnJ/2O9JRmx7EpxtnZ1H9TtGDDS5HNfqKkYsoQNS
	 mU3lcHLpvLz4wIKyE2inwkaww21/ux5KKNx6hUrMXY0yJx3/twEXLnaVsOzTyEGnqq
	 V+2+cqKx2XRgn7tJGnEZCBT7/caBzmUvEp+rJV+S8ljyGnM3NzlCagJjxHtnV+xBVg
	 kqsSLZVr9bhoQHc65Pe9Boz+gDgX5V2ppbT027RzoBnvOJ2rP/yRVPqKbprK53i4rc
	 6sQYgksDfAFxF8NHe4vwK2/0EuqqgtNuUQClEAINL2Ax6H+xH6oigOtqJ7bxkswxmJ
	 zXBJtj5dik/tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/8] perf hisi-ptt: Abstract trace data buf and
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260827140442.2031128-2-liusizhe5@huawei.com>
References: <20260827140442.2031128-1-liusizhe5@huawei.com>
 <20260827140442.2031128-2-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 14:14:07 +0000
Message-Id: <20260827141408.37C531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Abstract the base address, current offset, length and packet type of
> analysing trace data into structure hisi_ptt_pkt_buf and move the step
> of current offset into the corresponding functions.
>=20
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827140442.2031=
128-1-liusizhe5@huawei.com?part=3D1

