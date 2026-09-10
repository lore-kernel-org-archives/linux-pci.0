Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D73D315D58;
	Thu, 10 Sep 2026 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789028516; cv=none; b=WGqR/axAlu6LIZJ3BBXqSR7jdH2QcQ/TprY4rVN8AYAmWgnpR/5Args8gTzXH3AM2nu7nbwvnoLxnkXSfb1UtvHvwQgzzB6QUuzElEEZUrH0jcpZkzNpdQHAiQRpMEyc4OEoPqpb1PFHG/hmtZd4BB5jvUsFMcTpfo/03fQbvIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789028516; c=relaxed/simple;
	bh=oxeGRhA8DtqHuLIKB4cnd0JG7Y0fnVEZ8vwLncaOoeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDPm4FQaNqOCZ8FDwSTp0bEvUKjR0CBEMI9LTXwMOBcdvg5oKhLNVW631LJx4KakSPBH08MbuspMRyLVJIiWvNWl/pO4xANmvP/iV8Ogwy/AjmDc1dIF9h+x38LX+da6t9P6RPN5PSFOTJ8oyz5jT9Yd8Cs0MjC2r/xRmVC75NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SspgT5LM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SspgT5LM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454A41F000FF;
	Thu, 10 Sep 2026 08:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789028506;
	bh=8GF4xDsZqaS7iq8OU5KYL1pjRmkJO3BJ7MEyzCwyS10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SspgT5LMee/lQG8O64MraWzQjiwuMb6uu35533YhKkT790RGRN/lOAb7DWm1yrWx6
	 uS6XNAAjpq4nd5gHGhAlMCMeqSHJkAxu0QksNs5W+pocYHnt/07sZVJNIcvlYDQ1t4
	 LZFSW01gI3iW38ZgSHsDYdfp25cK/skwLDU00L4Wxpzg6G8kNW67xxGNWljIylb6NK
	 xdLne5m9N4ZTGpYK9ruZMoppdCy3yU/4jXxkwGmWOwSwhSMAAaFaPI7T4NRY690DGV
	 qZciMPAFcOTmThyQOM9Sm/Tbuh+TW+8ppo2YBAG0lDdc/Hx8N4e1wcfuq2jG5mzMx1
	 xtmU/DlvlclfQ==
Date: Thu, 10 Sep 2026 10:21:41 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jiwon Kang <kkjiwon04@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix coding style in pci_sort_bf_cmp()
Message-ID: <pvatjx4rsp27j5r7qpoqbvbxeqrm6g3xqmfvzflpij3o6z7v5a@xvgkni5kvrr7>
References: <20260730013820.20147-1-kkjiwon04@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730013820.20147-1-kkjiwon04@gmail.com>

On Thu, Jul 30, 2026 at 10:38:20AM +0900, Jiwon Kang wrote:
> Split single-line if/else statements with trailing
> return into separate lines
> 
> Signed-off-by: Jiwon Kang <kkjiwon04@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
