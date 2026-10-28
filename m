Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200043;
	b=UwX6ILm+OK1S7mvUvW9siCPvmT1rLJoqILUy1vgYhcOvkXyi02bzWrGMYK9wnw8gzCSj
	 h64doLwdJWZq8ASGcyuqRrcTznEMCpiPRQYBNAbP85bvw1xKp8VBi4YDRLruhGMoJErEU
	 H4eW+pJLF+kUGt9N/8UxEWlUBze6BgfWE+nFb+yuBYbWek1zLcYh//Hct/d6kxQuN7KTw
	 KZvuKwQ28jy7hCH4WnulDBUUE1ZXsL8RDz9aOb0VLfe/mNl4QVgdzi3Ai+Q7EFQ1XKT8W
	 YAywIPiL5aCzkwXGmylrCoatLxvEygo9/0F7R9M7n0TauiNhH1K5pJzqL0tGM1vtA4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200043;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:User-Agent;
	bh=zAexHz8E5bpDPAsaNW7aRPuUlLOJ5C/B47iIBOhDko0=;
	b=GlNLpUA15yGslJwcnljSgwtTQv9M0wm7vUYw8zTDJ9cbwuj0I4aENG99E6xZgmk4BX/o
	 Qrd3CVUOkNGc4vFcNoSCt1PAE5Nmnhuy9NlrDETp90Dod229Q7eKNOAElV7epsHIpx46P
	 tyPS8F7cIjrcfx9lrrui9DNm1Rfag+w/gFH9hA4kdyrtpqzdWKT3F2F0McLyuoajqb/HY
	 PMhVMFVoh6pZhrvXLCPlnrKvZh6hcxj/dlBfrHvWo5PiCMD2eLjByxH7seLiMqVM5PrOv
	 D9yT+XtsP7eRD5mwyqdrXvXGucfw2xlwU9Q59HhoqaiXJx0IzQc+1qT80ciHQJ3rG8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FE6606A31C
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 15:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8FE6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 718E768AFE; Wed, 28 Oct 2026 16:07:12 +0100 (CET)
Date: Wed, 28 Oct 2026 16:07:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Fengnan <changfengnan@bytedance.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, linux-pci@vger.kernel.org, tglx@kernel.org,
	namjain@linux.microsoft.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC PATCH 0/3] nvme-pci: dynamic interrupt moderation
Message-ID: <20261028150712.GA16374@lst.de>
References: <20261013223543.395054-1-kbusch@meta.com> <16e8bc03-42c2-4bc8-bce9-dab49aad66b8@bytedance.com>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16e8bc03-42c2-4bc8-bce9-dab49aad66b8@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 22, 2026 at 05:43:54PM +0800, Fengnan wrote:
> Hi Keith:
> 
> I made some modifications to DIM and then implemented a solution
> using the DIM framework. 
> Based on current testing, the results are now comparable to those of
> the previous patch.
> Here are the preliminary test results:
> https://docs.google.com/spreadsheets/d/1e8LQPnaDhmv50XlAM3XxI0TMQkhbk0bTZwlJP1Hzzdk/edit?gid=188992110#gid=188992110
> 
> If you agree with this approach, I’ll continue testing and optimizing.

І can't speak for Keith, but I'd really love to see this going forward!

