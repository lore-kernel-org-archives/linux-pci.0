Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D493148A7;
	Sun,  2 Aug 2026 05:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785649594; cv=none; b=PmYaouA9b02PzmFo8udGBeQpsuyoqnQ+dDkGcSQ+btnMTh2V1OnQUTfWiV3TCQtAByMVj0Kc1njhGMYFfJJNvc7NW956WKBVf6Uu91lhqnv5jsV23wTsFbaSrEPv+1w4I7hjyqKIueDknrvG915khilfVly9MksbVMqdFwIru6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785649594; c=relaxed/simple;
	bh=MqapeSfNopgYXh8J6thU9zppztHyJ13gCnQCSY/K5+Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=vA0GA6amn6AYnbezajyXKOpTxwGHdRzxQbSkhyZ94Zy6dKwInvNpq7icGNBzCkL3GKt+qE6RDASdv0y3DGvTTme7h6XaZL/De9YzcvIklOocw8zYcPFIVZVlQ0vZPkgF/uVnALS/CwXx7H4E+qmADeLHYws+E6CCqHs2AVjJib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpIwgUlj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpIwgUlj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B54E1F00ACA;
	Sun,  2 Aug 2026 05:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785649592;
	bh=WxhMRZaTW3jvA16d0Id8N7tbILuRU61GurYOALobZfM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UpIwgUlj62DgCKqLWODGmUVytwPztj+oUaaCsPQtgForKx8/hb4RHrDRW/C5dCvqO
	 b3gU8g6Vt458clRa/HZ7eJzdVgW9oE/A0QzkCT3YOPZBQS+V01dOpADopxEjqJA8o1
	 5V7bHP1Xe9sb1qsCg+36y9AFP7Ev+fzVPYDvjINRQQW9mDHL7qzljgIio9hIdayc93
	 OrinNFLjV5wGvr5S26wwEkh220ttgoTl8UQo4ONaAajbmqcLwc4HsMLbDvzG0ns59H
	 gWFSpeKNtKqZ1Gf2qfXFd64llX9DCnE6TjwQQ+8vnIMRG0hF80xYuKIsarcsZQa9Wj
	 dkul43QeqBKDA==
From: Namhyung Kim <namhyung@kernel.org>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
 mathieu.desnoyers@efficios.com, corbet@lwn.net, skhan@linuxfoundation.org, 
 bhelgaas@google.com, yangyccccc@gmail.com, jic23@kernel.org, 
 john.g.garry@oracle.com, will@kernel.org, james.clark@linaro.org, 
 mike.leach@arm.com, leo.yan@linux.dev, peterz@infradead.org, 
 mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
 adrian.hunter@intel.com, wangyushan12@huawei.com, 
 Sizhe Liu <liusizhe5@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linuxarm@huawei.com, prime.zeng@hisilicon.com, 
 wuyifan50@huawei.com
In-Reply-To: <20260730062709.534139-1-liusizhe5@huawei.com>
References: <20260730062709.534139-1-liusizhe5@huawei.com>
Subject: Re: [PATCH v2 0/3] perf hisi-ptt: Fix TLP header parsing and
 naming
Message-Id: <178564959213.665203.10969359308974116817.b4-ty@kernel.org>
Date: Sat, 01 Aug 2026 22:46:32 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 30 Jul 2026 14:27:06 +0800, Sizhe Liu wrote:
> This series fixes bugs and issues in the hisi_ptt packet decoder that were
> introduced by commit 5e91e57e6809 ("perf auxtrace arm64: Add support
> for parsing HiSilicon PCIe Trace packet").
> 
> Patch 1: Bugfix:
> The DW0 bit-field layout of the hisi_ptt_4dw union does not match
> the actual little-endian memory ordering, so the extracted
> Format/Type/T9/T8/TH/SO/Length/Time fields are wrong.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


