Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7451A361657;
	Thu, 12 Mar 2026 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326717; cv=none; b=nHt83EpPbncAbfI7YFj3B19g0XTl2fkCp1qDnRzSlw61XLzNxHd9/UtAaWmvCxnq+hTezPMHvMU17ZcjJXOZ/mOX5SbhkDGTP0mNpRAdvTu6RFuLG3XZsy7v517m9GDqDlcWT7L7R1P0PqGtf7PTkhSd+GYKGxiaBPnTg5ILsgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326717; c=relaxed/simple;
	bh=f3s75+CQUxUR7HHEUGHCuQeG4Ezfwu1t0v/itrtMcos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaHNtYYQpZPLENiQd3RrzVAMZiPbE7IDqrQ7eBf2JwSV6Uj1L1wgOZ6RDXwR4E6p9XN6POgONpX0fBSsRWhNALi1sRpHp2McrNb1Gt40Jg1P6TnLO8aKINHPYfTZj3IMKqubpmo6uzKRFiZJWfZ0BVAmTpQmPeYFRTzf3tZFBeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C3LKxIdN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C3LKxIdN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41CBC2BC87;
	Thu, 12 Mar 2026 14:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773326717;
	bh=f3s75+CQUxUR7HHEUGHCuQeG4Ezfwu1t0v/itrtMcos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3LKxIdNwLIOEjVoUrktMa+z9karg5dvoXslKoIia5CrGLmIEjfqkPrY7oPs70A27
	 X0A8jaFRC7WmFF7d1b9fIM75xWICCLEGhgdW6YQi3idTKPP+sVb+ZSafDbgLKjbh+5
	 MLLMr8q+KecZgxClbxiiay/s0gQPk5LcVYfaeFyU=
Date: Thu, 12 Mar 2026 15:45:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, aik@amd.com, aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com, bhelgaas@google.com, alistair23@gmail.com,
	lukas@wunner.de, jgg@nvidia.com
Subject: Re: [PATCH v2 02/19] device core: Fix kernel-doc warnings in base.h
Message-ID: <2026031258-armhole-marrow-e88b@gregkh>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-3-dan.j.williams@intel.com>
 <20260309163932.000073e4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309163932.000073e4@huawei.com>

On Mon, Mar 09, 2026 at 04:39:32PM +0000, Jonathan Cameron wrote:
> On Mon,  2 Mar 2026 16:01:50 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > In preparation for adding new fields to 'struct device_private' fix up
> > existing kernel-doc warnings in this header file of the form:
> > 
> > Warning: drivers/base/base.h:59 struct member 'subsys' not described in
> > 'subsys_private'
> > Warning: drivers/base/base.h:59 struct member 'devices_kset' not described
> > in 'subsys_private'
> > Warning: drivers/base/base.h:59 struct member 'interfaces' not described in
> > 'subsys_private'
> > Warning: drivers/base/base.h:59 struct member 'mutex' not described in
> > 'subsys_private'
> > 
> > ...which are simple replacements of " - " with ": ".
> > 
> > Add new descriptions for these previously undescribed fields:
> > 
> > Warning: drivers/base/base.h:58 struct member 'drivers_autoprobe' not
> > described in 'subsys_private'
> > Warning: drivers/base/base.h:117 struct member 'deferred_probe_reason' not
> > described in 'device_private'
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Maybe if the rest looks 'slow' can send this one ahead?
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
 
I can takt this now, thanks.

greg k-h
