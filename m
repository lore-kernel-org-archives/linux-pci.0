Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27672EAD15;
	Wed, 25 Feb 2026 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043058; cv=none; b=u6uz4LWewhn/xl47Mhz7Z3d36ROwTtyn92NdP3Iu7Rz1+KQhApf7id2x94zWmxdalCKhL2qds8eTVafhapSqO9hCIo5Dr11XTnpCCYSYMxXyS4V0cnrFweO9Sb2vvZ12yOy9Z/WPEWs8usR+ciZkyoNuFPbnLy/HBDqLPXzL9jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043058; c=relaxed/simple;
	bh=aGEZjMc+9o4fu9fekWMA3ubb1LICyq926GnBRIV25JE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VymN70Jw86ljuCf4SkPX07rWQXP/5CXTwW78KQtoGmR7Xisu73n8II0P/SOyBVhSn6n5yjoa6VlAnxddEaYmIH99EZXtRchhsdhNpGE/JfCKFRzD0gRMUQixFv7SXMUB8Syq38SLp0UJNEybRrEz+xCqqcMgiNoPzkZ3eh6rBAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3bkB9Im; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3bkB9Im"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AF1C19422;
	Wed, 25 Feb 2026 18:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772043058;
	bh=aGEZjMc+9o4fu9fekWMA3ubb1LICyq926GnBRIV25JE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=D3bkB9Im3rEUTJTxcWfIcIQEKDlqPwJ7gtno3YLieVu02v8iI352sSe39JVUqfQHn
	 +9tMy+lTmfFL9XTPJK2j3btKaZIoc64KQ57eLpMDMzQV1fcQtg6IX0i8zKsalxAMQd
	 ovb1rkObfoAsHv5FU1qEy4Ti2o2gABG2DIEuEtTOAXSXPD8H6o1HCY7flDKU1WenOT
	 YevCFKZwct/fUD4exM1TddPzBk98wNujLwuBoTiYkziTRcLHxcrl/hzuC9X5TjGFVi
	 LjnBBppEfGIgxPJjGD9ETyem/k3K2gCqfU8RuvR+i+fYy+YHghpbZOKptbs6Tc8UWH
	 dsal27yeNSiKw==
Date: Wed, 25 Feb 2026 12:10:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hongyu Xie <xiehongyu1@kylinos.cn>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] PCI: replace msleep to save waiting time
Message-ID: <20260225181056.GA3779670@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223061919.1408000-1-xiehongyu1@kylinos.cn>

On Mon, Feb 23, 2026 at 02:19:19PM +0800, Hongyu Xie wrote:
> In pcie_wait_for_link_status, using msleep(1) to wait for link status
> change.
> But msleep(1) can sleep for nearly 5ms.
> 
> ftrace shows:
>  0)               |                pcie_wait_for_link_status() {
>  0)   0.500 us    |                  pcie_capability_read_word();
>  0)   0.580 us    |                  pcie_capability_read_word();
>  0) * 10292.26 us |                }
> 
>  after changing to usleep_range.
>  ftrace shows:
> 
>  0)               |                pcie_wait_for_link_status() {
>  0)   0.320 us    |                  pcie_capability_read_word();
>  0)   0.480 us    |                  pcie_capability_read_word();
>  0) # 2483.980 us |                }
> 
>  So fix this by using usleep_range.
> 
> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f3244630bfd0..68532e248e51 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4519,7 +4519,7 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
>  		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
>  		if ((lnksta & lnksta_mask) == lnksta_match)
>  			return 0;
> -		msleep(1);
> +		usleep_range(1000, 1100);

Perhaps consider fsleep(), since it's a little more generic and I
don't think there's anything magic about the 100 us range value.

>  	} while (time_before(jiffies, end_jiffies));
>  
>  	return -ETIMEDOUT;
> -- 
> 2.25.1
> 
