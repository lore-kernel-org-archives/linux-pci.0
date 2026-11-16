Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794813136;
	b=QGVy88G1TMOYOwptlfscoeA4aQ0n9V7px1TTzPKF6tPsyR9/b3NaBtHQHJkSTTV7Q+ws
	 ZRYtKW27/fkEQnV6UDU4gsrYazSv8lJ2rfealXeL+QcgPPU4N8Y9EEN6uOhxW7IvUZ1bo
	 YUj/FVzEhMnBAARl7KpI4p9BmAsNhcrUe4nidRySi6tVBBLUVqOWEMp0wTFzkA2I3FVNa
	 mnqmrolULkljx52NjKgFi7M7I0kURQvgW082X/aF5mQt0WgUv3koUeevsupfKjF/FTyw3
	 p02kjo4Xs6kuXA096pejVIQHqGDdQIA4k4VzYFOOXq4YgWhHmvJ21WwxNGDyRh19mLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813136;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3ddNMHunRkB0O0QsoA7pd9wVv/0W9Lfu97gA1D6q22Y=;
	b=LI+SveguzIvk07U+4RyCjTu7kc0q2ZbzIk9Jsn9SNr/y1+ih1jHtBo8hO10I/KV9Ztoj
	 XvZ77XWXpNoKFWZGH8yUCU0BKCWRnzdtHF49dCe/wanVKV8Aw9xAvoTdlUYJBwyxvpiNF
	 Gjx5OdWj8xpCzvcBU93LsnNXjXgbiE9GUUEnCxuOsDZ+ppWqy8QRWFlSPRNBoVd2FPf3/
	 w1uIjOEpTLFCpmkepYQ/1JE3NFxsIzaIV5thhSfwvicPMoleZpXYK6UozXsP/NHIVr2ME
	 QkwgbcZhARbKmF6mByeDgYWdPk/U0nhnmInM024WwJbW12O0C8snaVeKj+EB/1AaPnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=MnxzOx9D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.17
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2AE606A31C;
	Mon, 16 Nov 2026 07:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF2AE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=MnxzOx9D
ARC-Seal: i=1; a=rsa-sha256; t=1794813102; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=IW6TlYuzRhN7B3QoDxPTrfOfNagoQUnVYFzJDo6cpswoRfoUF0FKH/flEQlFIVtwqKCCxeS6ScSzCHezdtIejrTwJGyOrYNkT/+EO6icZRul5nHsrp2XzU9WGIT4k4Pbup3up/PDA/uhDZfWRBMlxROqNW3Bzs1ihqg2xllR8Ns=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1794813102; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3ddNMHunRkB0O0QsoA7pd9wVv/0W9Lfu97gA1D6q22Y=; 
	b=kTlsDA4+ZAcC4gHDVf8rbiL04nJ9bJNvWGItQrrDBrrIZgD0Rqx08A4zT7yh90KDdiGpjcTbhDvLnWkh3I3vJDXD6Ec3KH1HVXsRqNScbjeWnaEd5jFKt5udMYHVcpdoGptNoEWGvfWGTHbme21Ra8Sp0sk/pw1A85ORJzPqh6s=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=MnxzOx9DB9Pc3DLzjtnsEsr35z3pdqGGQW7Mp5329orCMLRQj8xJR90OVU03I/0/VsUzquNuZRoOZWxRGnuBnt/sugH9RDH40HS5FlkDEeBBJ5S69DV57vfqCi1YBnUsYnCpuH9q6Iu//qhXd+/QjtBbw40Zj019bZnR8LYJZLM=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=3ddNMHunRkB0O0QsoA7pd9wVv/0W9Lfu97gA1D6q22Y=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1794813100805897.2580520315063;
	Mon, 16 Nov 2026 08:11:40 +0100 (CET)
Date: Mon, 16 Nov 2026 09:11:39 +0200
From: Igor Velkov <iav@iav.lv>
To: Matt Thompson <matt@boondocker.io>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/3] PCI: rockchip-host: Handle unavailable downstream config space
In-Reply-To: <20261113-rfc-b4-v2-0-d6b14f95c1d6@boondocker.io>
References: <20261113-rfc-b4-v2-0-d6b14f95c1d6@boondocker.io>
Message-ID: <20261116-rockchip-host-rfc-v2-test-1@iav.lv>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Tested v2 on Kobol Helios64 (RK3399, JMB585 at x2), 7.4-rc2, DT without
ep-gpios, 150 unbind/bind cycles, bind pinned alternately to A53 and A72.
A53: the fixup ran 4 times (debug print on the err path); probe found no
device and the JMB585 stayed absent until the next bind; no crash.
A72: the same read raised an asynchronous SError (bf000002) on the dmb in
__io_ar() after the guarded ldr; panic in 1 of 75 cycles.
Patch 1 does not catch this case: LINK_UP and training done are set, the
endpoint does not answer.
Retrying the link bring-up avoids the abort here:
https://lore.kernel.org/r/20261116-rockchip-pcie-resume-v2-1-a633e279be97@iav.lv
With both applied: 4 bad bring-ups in 150 cycles, no device lost.

--
Igor Velkov
