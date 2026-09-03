Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481934EBAD7;
	Thu,  3 Sep 2026 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452568; cv=none; b=Bvc6QTuMrlUFY/1oD23TL+v4ndpp9mkJlbFcPNK29LxnSC+AmavZUCAUQONK1Y5rF5HSd0EdttfGI3b0Zn2Mf3yEjEFdj22oyC1SnICYIV1RAi7A7Dw+JEnRie8BxTNx3swYzBNkH0pF4Hm7XYx8iZ+IAHEzFAy99lYYgIzNG8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452568; c=relaxed/simple;
	bh=tJ8ddU5NGCEdNZcy3TvG+t4vYue73F15Wk+3s/ckSXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emVMLpRsWZ4xShCVrI6YhmPLjcKXoB09zcdxWK32crPDrOKU8rJiVMDsGzQaLVHKSMYaIlzwdjXgDmt2CnjPpw9kalTyqLoHY/KVetkg4AqFTF+LbdMUsElSiePgW9OaRJgMkbdfnceNT7broEJN65shBNeUlomDgC2ftCqIq0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6V+x3gv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6V+x3gv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551FB1F00A3D;
	Thu,  3 Sep 2026 16:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788452567;
	bh=gB7TSTNY2WQB1YHsMJEbcoatSMPcBLT82nLlAE7SwvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G6V+x3gv0YwS62zDL4CbetsewzHq1a5nyoKDZJrr3ogKvTlUcnBHgS+ABpwHW/Na4
	 OUhYG1JrB48XBYW4tzQaPb0dXzw7Z2HjtAp/QHwlfnpsLqTcWFMoOKScofuBCOHk6o
	 8AWapCv2Gvmrpsa/MM/PrYSSQjd7CpIsgiLYtyLIClYhSx61jZCRHo3nZ0O55whLZx
	 y9bk+eSZtociPx4CCHXV9pgHPohZspTOclG1WvmYSblPKe+i9Pfh4V/no2fwPzGwDh
	 SroQIbCP4w+E6mCszt0L47XyjU1fd164AS+Vb9AWOqxrS8GesTWvkYAAo1pnIGv5re
	 gSkG71a0Xyj+w==
Date: Thu, 3 Sep 2026 21:52:43 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Devendra K Verma <devverma@amd.com>
Cc: mani@kernel.org, frank.li@kernel.org, den@valinux.co.jp,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v2] dmaengine: dw-edma: Cosmetic Changes
Message-ID: <apme09juKX_h8jHF@vaman>
References: <20260820091314.684871-1-devverma@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820091314.684871-1-devverma@amd.com>

On 20-08-26, 14:43, Devendra K Verma wrote:
> o Arranging macros in ascending order as per the bits represented
> o Cosmetic changes, typo corrections

I dont like the title cosmetic changes... maybe split to two and
describe these.

Anyhow this doesnt apply and needs rebase

-- 
~Vinod
