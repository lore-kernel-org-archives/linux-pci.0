Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.54.226.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748567;
	b=PSwi9exT5uNBkPLj12oD6l3PNkuYlnwtc9SYiAXPJ6Zyj01fhBdUwq9PUq+4bXx825cC
	 X/OIgxmGY3JKKfnDjY/ewObxD1JWPYqKH00L+uETrV10pf4vQ6zbPxMeUMDzZpldnahIS
	 G8IuCqlBLc18JebpA2QcF2aJtYyEdlJsKVMpWOONtCdNCJRtDqHGX6zhmPTE9FLFoUrb1
	 k8KMMCYyc4s36tZd7LpAZJGFjduHg3KNRZcU19j3q4R9QaUDdw3uTDvFFwfkwN1/qQIkM
	 B+POKLI86hHAFlDbvDmV8f3GfzF0eJ0LMn0coBXR3ryrl2P1R6ILiZ3v70t5zHmQ9cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748567;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0DsCfwC8cOS5KIWlpTxWKay+jvt63StWtkUJO1soz8k=;
	b=HNLoFDUGTK5W52I6nH7vGUgUx3o+rfgBs0ssYFJmLbIF2CiEyVck4fhi0tPmPk4OA2Yq
	 KNlQRbQuiZGbDo0awpqmWGNzdZ63pQXBETgm5fIZqzYyL7FGFE/YeM86Q90a1Pv5lunDh
	 uJYKQN4vCjMI3udYwD2ycaKRgRXR3I9p+m3+R8YrMej4KBprr9TfWR/rIn191zezwtOxv
	 9HSDwZoE2NOjz7hmHCj3IfnkzWUdNJKjH2rJSO8+H25GqYveefm1couPb8FfgeWpXu3nT
	 t8aFHveg7DyrS0bIcecy3lddisOlLsFbgqXVJg4hUH0PF0KBFL5NpgVBn/o1zh7yo4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tnode.com;
	spf=pass smtp.mailfrom=tnode.com;
	arc=none smtp.remote-ip=46.54.226.45
Received: from mail.tnode.com (mail.tnode.com [46.54.226.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7584C606A324;
	Tue,  3 Nov 2026 23:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7584C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tnode.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnode.com
Received: from localhost (localhost [127.0.0.1])
	by mail.tnode.com (Postfix) with ESMTP id 007BD1260034;
	Wed,  4 Nov 2026 00:29:23 +0100 (CET)
Received: from mail.tnode.com ([127.0.0.1])
	by localhost (mail.tnode.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eu92MyYx2nq6; Wed,  4 Nov 2026 00:29:23 +0100 (CET)
Received: (nullmailer pid 252777 invoked by uid 1000);
	Tue, 03 Nov 2026 23:29:22 -0000
From: Mitar <mitar.git@tnode.com>
To: saverio.pub2@gmail.com
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/DOE: Add debug messages for transaction failures
Date: Wed,  4 Nov 2026 00:29:22 +0100
Message-ID: <20261103232922.252762-1-mitar.git@tnode.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721193310.1179300-1-saverio.pub2@gmail.com>
References: <20260721193310.1179300-1-saverio.pub2@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

On Tue, Jul 21, 2026, Saverio Miroddi wrote:
> On a WD_BLACK SN8100 NVMe device (15b7:5050, firmware 830ZRR0A), whose
> mailbox creation fails on every boot, these messages identified the
> failure: the device accepts the Discovery request but never presents a
> response, and the transaction times out with the Busy bit still set:
>
>   pci 0000:05:00.0: DOE: [500] response timeout, status: 0x00000001
>   pci 0000:05:00.0: DOE: [500] failed to cache features : -5
>   pci 0000:05:00.0: DOE: [500] failed to create mailbox: -5

The same happens here with a WD_BLACK SN8100 (15b7:5050) on newer
firmware, 930BRI19, in a Framework Laptop 13 (AMD Ryzen AI 300) on
Linux 7.0. Both errors are logged at every boot, and the drive
otherwise works normally:

  pci 0000:bf:00.0: DOE: [500] failed to cache features : -5
  pci 0000:bf:00.0: DOE: [500] failed to create mailbox: -5

So the firmware update did not change it. As the mailbox never answers,
would a quirk which skips DOE discovery for this device be acceptable,
instead of the two errors at every boot?


Mitar
