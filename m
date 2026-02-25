Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18AA3E8C7A;
	Wed, 25 Feb 2026 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039359; cv=none; b=ZhLfPS8bnPKPHHrV+DFJWqnoZo+RwfRBJ42Yf0HeI5AVmZNwNmWgNJ/GljEmktYSj54vqFre8BdIE35C32AjanPmhqztv0qB9pGWZVaaajsUtV7kF2FKVYbIhYVJddtA/WHeZhj8+ngU8XpCiWmLTZK3+0L/4ZQipLlla8HJ6Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039359; c=relaxed/simple;
	bh=GwSv/fr4/40H7RG9ahdqbZZwcu2wTCx6k3knzyjwiog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHI/H5BqyH91aIg7IU6AD8MCGLC/uV0nY/wq7Y4DnQDCWlDmcvlyrLrdTakG/lJ6mK5spOS72I1SBekCPF61riI9MQq8B8BRfDSH996RZcZVyy1znKqULcwz+AAN4c9oU3PybyZY3fh8jbpG3/ICYbyMkJVlmgV8S9CyuWvsIFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRxGxcab; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRxGxcab"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772039357; x=1803575357;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GwSv/fr4/40H7RG9ahdqbZZwcu2wTCx6k3knzyjwiog=;
  b=jRxGxcabq0tQ4BsUHjAVGI7l3hyp822PLczSvF+ZkbZrsWxWs8M5jtdy
   +F84H/IcIEsMLw0XvviDeBLMA6bBJPJSPWPAkYc8m3X/n6RYqD0NtFVMR
   MjVJgAVWANnpRslhKHpEVBQaXzVEcRGre8ko4Y0+wIsam07pGBAogO8os
   nh7PdV7y6sdHAhtCl+O40IB0B2hDSaWncYNPsLV+xa3u7Vwc+7fh01cdI
   RRJ2YnsbjLITT43UKcECw9hVpNVYlanaY3f7V6qjQPFA/YIfxxVJsTYNI
   UwY+cqJ3MazQphI6lfFiIyb4qjEd7TGphoVGNopItc2IU8RCMmKH5CAW4
   g==;
X-CSE-ConnectionGUID: oJuUldBGSDSMg/797LMEWw==
X-CSE-MsgGUID: euDZgAecTYmNcMVBGkKV7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73191320"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="73191320"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 09:09:17 -0800
X-CSE-ConnectionGUID: p+RkI1awStWhQ35b9KVgjg==
X-CSE-MsgGUID: FlMeJJhiTfyOqczWtps7Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="216440022"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.98]) ([10.125.111.98])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 09:09:16 -0800
Message-ID: <3bdfe35a-10d8-4561-aaef-d4b1e77d478a@intel.com>
Date: Wed, 25 Feb 2026 10:09:15 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] NTB: epf: Implement db_vector_count/mask for
 doorbells
To: Koichiro Den <den@valinux.co.jp>, Frank.Li@nxp.com, kishon@kernel.org,
 jdmason@kudzu.us, mani@kernel.org, allenbh@gmail.com,
 kwilczynski@kernel.org, bhelgaas@google.com, jbrunet@baylibre.com,
 lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-11-den@valinux.co.jp>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260224133459.1741537-11-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/26 6:34 AM, Koichiro Den wrote:
> Implement .db_vector_count and .db_vector_mask so ntb core/clients can
> map doorbell events to per-vector work.
> 
> Report vectors as 0..(db_count - 2) (skipping the unused slot) and
> return BIT_ULL(db_vector) for the corresponding doorbell bit.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index 0018adc35f16..7c76039a79d2 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -414,6 +414,34 @@ static u64 ntb_epf_db_valid_mask(struct ntb_dev *ntb)
>  	return ntb_ndev(ntb)->db_valid_mask;
>  }
>  
> +static int ntb_epf_db_vector_count(struct ntb_dev *ntb)
> +{
> +	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> +
> +	/*
> +	 * ndev->db_count includes an extra skipped slot due to the legacy
> +	 * doorbell layout. Expose only the real doorbell vectors.
> +	 */
> +	if (ndev->db_count < 1)
> +		return 0;
> +
> +	return ntb_ndev(ntb)->db_count - 1;
> +}
> +
> +static u64 ntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
> +{
> +	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> +
> +	/*
> +	 * ndev->db_count includes one skipped slot in the legacy layout. Valid
> +	 * doorbell vectors are therefore [0 .. (db_count - 2)].
> +	 */
> +	if (db_vector < 0 || db_vector >= ndev->db_count - 1)
> +		return 0;
> +
> +	return BIT_ULL(db_vector);
> +}
> +
>  static int ntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
>  {
>  	return 0;
> @@ -548,6 +576,8 @@ static const struct ntb_dev_ops ntb_epf_ops = {
>  	.spad_count		= ntb_epf_spad_count,
>  	.peer_mw_count		= ntb_epf_peer_mw_count,
>  	.db_valid_mask		= ntb_epf_db_valid_mask,
> +	.db_vector_count	= ntb_epf_db_vector_count,
> +	.db_vector_mask		= ntb_epf_db_vector_mask,
>  	.db_set_mask		= ntb_epf_db_set_mask,
>  	.mw_set_trans		= ntb_epf_mw_set_trans,
>  	.mw_clear_trans		= ntb_epf_mw_clear_trans,

