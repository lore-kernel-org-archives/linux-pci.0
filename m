Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E3B3B42DC;
	Thu, 30 Jul 2026 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394254; cv=none; b=RX6IkGp7kLmmdo1RaAbJnDcsfIBhZHR/TdWZVbbcpt0SUVu76e6tBW02nMty4s+x2jiZ8Kpob4rm62J/rCv+42xiz04OLnqs9Z4yvAoXKUQnbEheX5X/UheUdPrkIiTF7axWsRUxtOYt/K1vQAWMGHhNOGi7q24K/WFzPxEOvUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394254; c=relaxed/simple;
	bh=PsENX3SOFwXHPZknhwGhoVZLQpVuobODLiBQ73pyTNQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MwLIKQKaAILV0w/NYroHDDr+zuvhsAxZfUUTeLgds5Q2lnN7Fs7qV7QEV4beaZGS3ZY3G7qqn1Mvh3+3QAEIMpsqSFxq40Gtkq0ovZxkS87GK5xyL9KDaW61Q0jOWU4/fTh4CvqQE/hMloCMABV0XtFssuLuOYgmpLYMfq6fnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUc6zfHf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUc6zfHf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E875D1F000E9;
	Thu, 30 Jul 2026 06:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785394252;
	bh=PsENX3SOFwXHPZknhwGhoVZLQpVuobODLiBQ73pyTNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fUc6zfHfuB5wlw9G/SHuFyz2Vmwexce1EyuHEttoXcJfYNLB+x8131kukDHMAghvI
	 qKNwQe4F4FlnZyJ9aAEvt4iQUD8LT0KSbNsci9g2qpoNJ9C5a2/puBU+5tQ8afq+bI
	 W/xX2Ka/LNyEd8/p+oL0Tbu9ZUi7uIykjP4UGVdnynYBSWKFu3hItQ5WUIzQOX+d/t
	 07wRcx8dnMySnDBBP1mDbUoaf91P2ycBIcF8Gq70yZJz49eGgbo9BUiXBIKN49Mu6y
	 dNozo2P08G8bfnLjwSI/wF6HZOMkAUEI/QCjkCUekpFJSGe8Z/Tt3MFv4+cPjpk1bB
	 geB5kcMMxhVZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] perf hisi-ptt: Strengthen auxtrace event
 handling and packet type detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260730062709.534139-3-liusizhe5@huawei.com>
References: <20260730062709.534139-1-liusizhe5@huawei.com>
 <20260730062709.534139-3-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 06:50:51 +0000
Message-Id: <20260730065051.E875D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Fix pre-existing robustness issues in the hisi-ptt auxtrace decoder
> reported by Sashiko:
>=20
> 1. Endianness in hisi_ptt_check_packet_type(): The first 32-bit word was
> read with a host-endian memory cast (*(uint32_t *)buf). On big-endian
> hosts analyzing a little-endian trace, the bit[31:11] 8DW magic check
> fails and every 8DW packet is misclassified as 4DW. Read the header
> with get_unaligned_le32().
>=20
> 2. Heap out-of-bounds read: hisi_ptt_dump() called
> hisi_ptt_check_packet_type() which dereferenced 4 bytes of the buffer
> without any size check. A malformed or truncated event with
> auxtrace.size in {0,1,2,3} may cause a heap OOB read. Pass the buffer
> length to hisi_ptt_check_packet_type() and return (defaulting to
> 4DW) when the buffer is shorter than HISI_PTT_FIELD_LENTH.
>=20
> 3. Integer truncation: event->auxtrace.size is __u64 but was stored in
> an int. Traces larger than 2GB became negative (malloc failure), and
> huge sizes wrapping to a small positive caused a short readn() that
> left unread payload in the pipe and permanently desynchronized the
> stream. Use u64 for the size, reject anything larger than SSIZE_MAX
> before malloc (same bound used by auxtrace_copy_data()), and compare
> readn()'s return value against (ssize_t)size to detect truncation.
>=20
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730062709.5341=
39-1-liusizhe5@huawei.com?part=3D2

