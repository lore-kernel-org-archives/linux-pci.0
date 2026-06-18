Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E9221F20
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814078; cv=none; b=XmKIFn35xx9h3Wal6p509fgwhc5JRHsLsWwXK+oKuNcElqFmtb06bW+i8FxHuRECpaf0VgVQo6rnw7G+NOrbSWt1xNoIv0JjQER7cSD3OqL8Fgk11QtvvQ6anEN0bguI7qfs2Wx/RKk5IhYoZ2waMA1uGyEWBNX306a60hder0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814078; c=relaxed/simple;
	bh=iWT+qFZ8akk70Yu23JoTJYfgUgObRmSsSv8aHyo13dI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=t1TBzfWES1jg783d9udcVmBsVIyak0TEMgyem3lF2qXHq3S+FOAcvEpgEjyqktqRZ3gBTHCGzzn2iHoQY0tUts17KCYFL71h6UrA14pv7Y+trSqQ9VqW5GcsmQ3pRjchTSX4mX5EnT/numlxPUH5LFvEUD3usT+FEiCA+gtvVxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdpsdITJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdpsdITJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A041B1F00A3A;
	Thu, 18 Jun 2026 20:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781814077;
	bh=aZ30rkY6fS83NCgqNmS+ptIKL+DjMGIyFj15frsFJQs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=KdpsdITJeQHgSmpqKq2UztrCsVjnm2bhB8/r+Om1j9qhYjHE/UO5XryJKskXNHYWM
	 ETGsZzHLlkcdWH6Wb1DtbOSVR8z4fZBBUntw7sap67GMlxsdsT9z48qCXXfLciRFh4
	 QyleSgj6YYvQhRZ/TLZijmqAqpQOT2I9DMn6c85GA07sUTaJdoVl3GSbZasfkB+X2+
	 tBEPGyR5Pc4IAv/dOfX4sz1svueJ1sVxe+3+0kwZbWb3KgwjkOljeVzHdP6jNIwe21
	 DHO5JZeHkAQ66NoJdLjZMOLFkMt62tghiE5X2bTajtdmFPiMn8jGvZv/jm3X/re3WP
	 pL+qSQPSWpfMA==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id DA554F4007D;
	Thu, 18 Jun 2026 16:21:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 18 Jun 2026 16:21:15 -0400
X-ME-Sender: <xms:O1M0att5GbI-JYjQcTva1fX0zT22HihULMC3qFzE8TMXxqyKlMQn2g>
    <xme:O1M0anIS54Yk2MNhJrSPTYJQ5-85M0sOwho5tXip7CXGEpWiyBJSGpwjjons3r0IK
    KM5PkyaBqqRQ4UUxGOOfuBKk1gFLjBG_qxlDcO6gZfOWra6Sl93ZBM>
X-ME-Received: <xmr:O1M0au8awi-ipQU-_oW4o2nHoEkjDoxF9aU1OiRRNnp-A5F1fzgxeBQPEAb7syUct58xS13jJJc8SodDIrXC314OOcc8Vq-0o74>
X-ME-Proxy-Cause: dmFkZTEhHMDBCmbbuuEzAkjQa+xVRVg1pXOIKKbFjE8CkLdbCvLexC835JvhvihDO7WJWU
    VmSSK/SoQJ2K/G9nB6X94J970u99PrBGykcXhzPIcJzjvNDe2Q6ftR5c24+cudL2QbUAL2
    4OV/V+8Qi3Wh8DW0pEYlyefFX//g58V6oCMUiZw6PLZVO/lc8DhOjSpwyVzM9SOMF/2X76
    APo9eCFdUs0GTkMa6aKgkhTfit0BUU9M/mGOA1bs2hnvmBJJJ1xPbSDxVUFizXjxFEBpNC
    C2VxtLSMGErOfZyn9QDHQYX6c19EWe/JOIRzz4fobxLDUwT6KLX0MChqET+FjM6/19yHN1
    hvySMHI3giy7aeti1KSN37RZqo3wfdV4R/oXKmBf94WajsfrVVUndiRVa7A3hMqQTIWxVB
    FeuBfdi83envkQioYY4MJyk0QSkeNHGcrQnPFnQHQoh6j3MgxR64ri9x6p6T5wfMFf8t6B
    A2ndJJUVOGy7IaK1L6ZYMlkvQxgW/+fS8cYF1pqtZzeItSv0pa0jyntKQgiHhaGdv7l06O
    QA8fwubtLoi6wlPdz8Giz+yptzNGFd7ff79+4idN+e07VZwmZZ4BECSVJyenWUdrlESC2A
    WVjXViBDcoS/62ShmD1NBua/E0Ujq7cyOZLYlJrHaNLVjft908P19nWV9JRQ
X-ME-Proxy: <xmx:O1M0aoyReSLKsplOw081p13NNuYGKfkKOtycxTmg-wQTBMPP0M-EvQ>
    <xmx:O1M0aj4cce8fRhVn4ekR_1kagplSJ83BQFi5vhiZYFI71PVimbSFXw>
    <xmx:O1M0an-1Ge5UrpDgTAJNUms7hfGx3wSY1MB280Zw1isCTK9FeCXgZg>
    <xmx:O1M0agofo4BvDmL8GRpAzBGJvLxDXcPKCFLh217I6kBYaYvHLTcibw>
    <xmx:O1M0agpReBHYW6F2EK4jfdtiS3OTz8ohgPPZniiNSDipre_QYBT-UYPR>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 16:21:15 -0400 (EDT)
Date: Thu, 18 Jun 2026 13:21:14 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, 
 linux-cxl@vger.kernel.org, 
 linux-pci@vger.kernel.org
Cc: terry.bowman@amd.com, 
 bhelgaas@google.com, 
 jic23@kernel.org, 
 djbw@kernel.org
Message-ID: <6a34533a43730_299c3a10060@djbw-dev.notmuch>
In-Reply-To: <20260618170723.2010490-1-dave.jiang@intel.com>
References: <20260618170723.2010490-1-dave.jiang@intel.com>
Subject: Re: [RFC PATCH v2 0/2] PCI/CXL: Add RDPAS support for CXL.io
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Dave Jiang wrote:
> v2:
> - Added multiple DSP per RCEC support.
> - Added boundary checks for reading MMIO
> - Addressed issues raised by shashiko
> - See individual patches for detailed changes
> 
> The series add RCEC Downstream Port Assocation Structure (RDPAS) parsing
> support to CXL.io. RDPAS is an ACPI table that is part of the CXL Early
> Discovery Table (CEDT) defined in CXL specification r4.0 9.18.1.5. It
> provides the mapping between RCEC and downstream ports. With RDPAS, the
> error device can be directly found when an error is reported on RCEC,
> without walking a number of RCiEP in order to determine which one reported
> the error. While CXL.cachemem is supported by RDPAS, there is no easy way
> to discover the source id of the error and therefore finding the Linux PCI
> object for the RCiEP. The intention here is to accelerate the discovery
> of the error by directly locating the error device with the given
> information.

Can you clarify why this "acceleration" matters in practice, especially
when Linux needs to be prepared for the RDPAS to not be present? Did
RDPAS ever ship on a CXL platform?

> This series is based on top of Terry's CXL error protocol series [1].
> Looking for comments on the series WRT if it makes sense to add on top
> of Terry's error handling for RCH/RCD devices.

What is the correlation with Terry's CXL.cachemem protocol series when
this implementation claims to only support CXL.io and Terry's series is
about CXL.cachemem protocol errors?
