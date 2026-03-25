Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA8E285066
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469214; cv=none; b=BxGc/7h51APcnxEwhMIjGzakegRzKJbpe8H8gyf9+jhrOavPNVoLK/mmWQ0lnsq1NxIKOzUiR5Ngp1zTH8I6ZZfh4FgRn5Z5ZzVFNXEAYNAwuTWRkC3nuPxsOwNZjTr64iSaOZOTO8ARotftCklyj0LM+GMvoU9hlo+eS5osDMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469214; c=relaxed/simple;
	bh=QWkkdA+pFF8rjilsaUm1i/vpWu+c/k23cgJdC8WUDOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeV0962gHrcRXsRWYvMuhW+38SFLml+zG/CEhDhsSEHLK0DDigOdyCvs+YrHfbn3A0eR9uYJF0HMX1F0pqp3u5svAjqwTupqwx1e6I2FvuH0MBlwqDiBP53PR4jRQ606ZXOhC0alC1hZxu6LrmnmStY3lyfbROVJ3kCC2puCtAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XOmpIf3w; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XOmpIf3w"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c742723c863so183683a12.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 13:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774469213; x=1775074013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+fZRp4AJi5cb/F6jA80ZrndPdXYxEQL1IK9u8/P+m9k=;
        b=XOmpIf3wx3OAbYuBhazQbr1ZVOYiuW+8XsO0/K8RYWS3pqy/6NzSJ5O/zdVru6DhcX
         TN6TGjZnxbzAHb449USGJQVZniTerw0en2lgBy3FjoXYn0yAjHyngXhNjCR82oB3iiht
         gfGhIRTHxeS9ZrUjf6Lr+jDGi5pJA//Jg1aa6+rgnMwl0FD0kx++MMoKWg6pjEvs4ES5
         FwzwIixpP2SiehviX4OWfOpTkR2ae0/WarXcOTsbL/obTaljzRiwBU9Oh5K9PunnEmBi
         wgLr3NLM5/3w6YM131plNM2nDc2A7DgzxLS+xfohjZ4x8siHv+E7wnBG6STMqu4yfXsp
         PYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774469213; x=1775074013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fZRp4AJi5cb/F6jA80ZrndPdXYxEQL1IK9u8/P+m9k=;
        b=Q+jGuRJPnz/BVMmugub6AoUPU81CxrflLOoo6kJpRdVCyPUtJTPvdfXQchYwMrPdJK
         adfxw0kYcJ9VpjxXtW3j/RPKRVqpsYG2MrIhhg8cdvqIi8mBkSnEIcZI/opMoYp9u0Rr
         kZMYW1GHSJmTE9ozm8DKIGswPIC592z3sw9WXMNkoailYaH0+qsm9RG7jCuqIJCqMM3b
         dDhxbXq1nSiQhQPjmB+i/6MHZ9nVRmH4NU8ekZ27FqCNfRStFTF/Rspz//uq2bioUdIt
         TK+IuSQi2qkB0gowLmPSDq0mN5/xlq9AMnjSwuVZnZ13x4MyVJ5NK76o9VUQnbQCZTdc
         7aLA==
X-Forwarded-Encrypted: i=1; AJvYcCUt5PK8ksAtvgoYfcqXWkdEDTsVEkAtiHKRXStTYVCZJsMswWClnePXksH1gkwbmEmRB1kus3H9p30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza8uSPbrqkE+ZaExiNhdk24TKCIHWLJcBTQNKUD7AKoXmHCpYl
	tLS+fkN88ycotRmaORlbn5OK8VG9fOiMCXJIX0v+Xef3uzpcWQRYsnMiEl9oRAg9RA==
X-Gm-Gg: ATEYQzyGWayyore4Le/jvtKKnbonydOLv6T6ypfXu6AqjDwa9YPXyfp8KRv4TOLVlxm
	eHuRrVbzjpUpqwB84xfjXfqhhqoHXTPkry74Cd5uckD4X19vL/Ocpc21HkmTJDIUhE8V5Cw7yPj
	E+ZDNhSgpYWnEMcOhYmGmRSRK6/nyO0wfiba5sLDE0cItqVpH/eKKaIuDB1Tb0TjhcMIWrT8RSd
	IO322AyT/zRM3eoZJBWQtTNvCdNCeBYbCBXtinokrZiNcs0YDYj0a4l/4XQ4HBgw8OIVPduSkSM
	ayBppl/lN1SvjnlDXaVNR+zTgPXT4hrnyIpcvFotzCzPfG8eTJ0zETHL1u+iQTE6y41+jm/Ymw4
	2Nx+lJqDD21DgnNmIdd1UeA3FsU2X5Lh4xbFIp4UEJJUk69pLdnuJ2T/5cg+KOIKiKNrsqQ+ZxX
	5LUOq3Veec+HSzB0hcc7HrVkYCrSBl/d0iIbvclHDrQZIDCwcXZ0YfknFQokWumg==
X-Received: by 2002:a05:6a20:8ca6:b0:398:b3bd:de58 with SMTP id adf61e73a8af0-39c4aed5082mr3746836637.65.1774469212632;
        Wed, 25 Mar 2026 13:06:52 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7673819da1sm305751a12.11.2026.03.25.13.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:06:51 -0700 (PDT)
Date: Wed, 25 Mar 2026 20:06:47 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	Askar Safin <safinaskar@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Chris Li <chrisl@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	David Rientjes <rientjes@google.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	kexec@lists.infradead.org, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>,
	Marco Elver <elver@google.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v3 02/24] PCI: Add API to track PCI devices preserved
 across Live Update
Message-ID: <acRAV7IK6RW8h_QM@google.com>
References: <20260323235817.1960573-1-dmatlack@google.com>
 <20260323235817.1960573-3-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323235817.1960573-3-dmatlack@google.com>

On 2026-03-23 11:57 PM, David Matlack wrote:

> +static void pci_flb_finish(struct liveupdate_flb_op_args *args)
> +{
> +	kho_restore_free(args->obj);
> +}
> +
> +static struct liveupdate_flb_ops pci_liveupdate_flb_ops = {
> +	.preserve = pci_flb_preserve,
> +	.unpreserve = pci_flb_unpreserve,
> +	.retrieve = pci_flb_retrieve,
> +	.finish = pci_flb_finish,
> +	.owner = THIS_MODULE,
> +};
...
> +static int pci_liveupdate_flb_get_incoming(struct pci_ser **serp)
> +{
> +	int ret;
> +
> +	ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)serp);
> +
> +	/* Live Update is not enabled. */
> +	if (ret == -EOPNOTSUPP)
> +		return ret;
> +
> +	/* Live Update is enabled, but there is no incoming FLB data. */
> +	if (ret == -ENODATA)
> +		return ret;
> +
> +	/*
> +	 * Live Update is enabled and there is incoming FLB data, but none of it
> +	 * matches pci_liveupdate_flb.compatible.
> +	 *
> +	 * This could mean that no PCI FLB data was passed by the previous
> +	 * kernel, but it could also mean the previous kernel used a different
> +	 * compatibility string (i.e.a different ABI). The latter deserves at
> +	 * least a WARN_ON_ONCE() but it cannot be distinguished from the
> +	 * former.
> +	 */
> +	if (ret == -ENOENT) {
> +		pr_info_once("PCI: No incoming FLB data detected during Live Update");
> +		return ret;
> +	}
> +
> +	/*
> +	 * There is incoming FLB data that matches pci_liveupdate_flb.compatible
> +	 * but it cannot be retrieved. Proceed with standard initialization as
> +	 * if there was not incoming PCI FLB data.
> +	 */
> +	WARN_ONCE(ret, "PCI: Failed to retrieve incoming FLB data during Live Update");
> +	return ret;
> +}
> +
> +u32 pci_liveupdate_incoming_nr_devices(void)
> +{
> +	struct pci_ser *ser;
> +
> +	if (pci_liveupdate_flb_get_incoming(&ser))
> +		return 0;
> +
> +	return ser->nr_devices;
> +}
> +
> +void pci_liveupdate_setup_device(struct pci_dev *dev)
> +{
> +	struct pci_ser *ser;
> +
> +	if (pci_liveupdate_flb_get_incoming(&ser))
> +		return;
> +
> +	if (!pci_ser_find(ser, dev))
> +		return;
> +
> +	dev->liveupdate_incoming = true;
> +}

There is an inerent race between callers of
liveupdate_flb_get_incoming() and liveupdate_flb_ops.finish(). There is
no way for callers to protect themselves against the finish() callback
running and freeing the incoming FLB after liveupdate_flb_get_incoming()
returns. Sashiko flagged this as well [1].

After some off list discussion with Pasha and Sami, the proposal to fix
this is to have liveupdate_flb_get_incoming() increment the reference
count on the incoming FLB. We will add a liveupdate_flb_put_incoming()
to drop the reference when the caller is done using the incoming FLB.

I plan to include a patch for this in v4.

[1] https://sashiko.dev/#/patchset/20260323235817.1960573-1-dmatlack%40google.com?patch=7974
