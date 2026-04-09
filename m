Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97D328689B;
	Thu,  9 Apr 2026 22:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774899; cv=none; b=GnQgfNUKYlC6QI+fWIwRQ2F+yrxT1/pXWzaC0mczZAuYRmTen+NF97vaarfSM0+DWLPOjLvUKm6+ddWtfr6DszhSLGsr4EL1OmW31KMBwmIImPT/+UdeW/m1SlpVQx7rwARpRf0x2062whavyA3tUh0ET08yQcN6vGqr3WIvj3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774899; c=relaxed/simple;
	bh=0oL5awt3cXx2sknqx97a2G9VtHAR5/XaCYlAVD5wtmM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=J+5A/3bOdiZAVBFVLKPXcKyp4b9ajvq+KsMVUp7xAj9I/1vKI261GUq4Skghsv/r+7pe5KnDlvMa3uStKnSMrsk2bUiFrBFvyNC8pr0VUtjUTL1dvj1V7znaEQFHV2U3GMXCq/X/wRr/rL8Flw/W6U3Sc08wszGa5A2oER7SeeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=rBb4V20O; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="rBb4V20O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=V3BWoxQtfgS+TehMWmtTBxOeCWicbu92UAzYU7SCxWU=; b=rBb4V20OwhjR5kQNGOe1lrTKS3
	60u3LEVsEGTzcJ/rjwmmDweh6mCnz6fXA2h8Uu6MUuiwq0uVFNr/kmeSqadJWUUtL9SyHHwi2nVd4
	zvqAJBVI4PvYo4WHSLY7cS+eUCB1ycTppl73IE37ZiHtG0RNffYnBfytKr5w308Sc2iMr9xmXkovH
	mx8CR6xhvoiDGYsAK9ekMlXYEnGJNUybCww1gVf6zACgnXWHeSDWHn+mh8uesFC0+CXs9WxYftjhE
	EdaqxPxexKQ6BTS0BEUZamVKJPE5lejHqyRYYj0CgM3er4K1VeWT4Txp3dLO12ewefaURbumeIhnv
	t2mqjeNw==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([96.51.150.74] helo=[10.0.33.11])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wAyAb-00000007s6m-1uxy;
	Thu, 09 Apr 2026 16:48:18 -0600
Message-ID: <03276aa4-cfe4-4698-9270-9596df4d30ef@deltatee.com>
Date: Thu, 9 Apr 2026 16:47:48 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jacob Moroni <jmoroni@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 David Hu <xuehaohu@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260409150123.3538444-1-jmoroni@google.com>
 <20260409150123.3538444-2-jmoroni@google.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260409150123.3538444-2-jmoroni@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 96.51.150.74
X-SA-Exim-Rcpt-To: jmoroni@google.com, bhelgaas@google.com, xuehaohu@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 2/2] PCI/P2PDMA: Add Google SoCs to the P2P DMA host
 bridge list
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-04-09 9:01 a.m., Jacob Moroni wrote:
> All Google SoCs support p2p between root ports, so add a wildcard
> rule to the host bridge list.
> 
> Tested-by: David Hu <xuehaohu@google.com>
> Signed-off-by: Jacob Moroni <jmoroni@google.com>
Looks good.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

