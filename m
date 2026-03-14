Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE2229E0E6;
	Sat, 14 Mar 2026 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773511967; cv=none; b=lDgCXbOEDNs/mrA7E7Po2NTQeR5OsY8rjuQhrln4Yangtyhh2Np3gWgYyHbYfDvgB+EhYYz1tjLYN7E6/f4ZdUL7mQKv+sxaNDhvbM/R6DS3zxoYg5BHaA9XkIDyXPUSKbDp6Z1WxGyMGMk9YfJHwAxWKuZn2R/Pa88SYw2dOuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773511967; c=relaxed/simple;
	bh=VAnfODFSMu8TaP+1ZgSSXTAsMFdEwNGSTbJD6+9zfss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdQaiR9a7Dquoel1IRWdw6G65XnJOD/IAUUlvbvvsb7sj+asNUh6cccHwycQOw1J2TcZ+5dZ5k+mZxF4lnP7kSyt4hmjX7eHX1n3kk5c4hyVOcjdihuJI7JB5ITy9m3j3mNqu/SYXaZpC7MLASXAghQn6umv4QsfOKn4JAiSUWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWdPyo9J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWdPyo9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23171C116C6;
	Sat, 14 Mar 2026 18:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773511966;
	bh=VAnfODFSMu8TaP+1ZgSSXTAsMFdEwNGSTbJD6+9zfss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MWdPyo9JyO9zo7PY0vXzAC0iw1fLPvet5F/Ey8qbO63ZSQqNaKKZEhdzUsH6a2/+1
	 zcIsoNW54n3TPKRaIQP/wRefGLShUN5UlWeTD3zpyZifrHHzyhLELkpMK6hojZ5R1H
	 jclZMOGgI9dNULvN8MWrteMGkAuyZR9IR73EpPIo0AuzqRsHMiPdL3OQeLWRxdC/PC
	 hJk+tTJBPZ4QL/gS8ufpjgDft40nNpgCFVuzFgYl3TkhGbcxKElnfqs8g5Hsf2iiO8
	 rC0uEj9E3de6UGKz90Rbjx5Nx3i2Tge/HuutZgF17oB80QNT2O0fnNTCZlQ+1s6vEo
	 7ZGqegjCK9PXQ==
Date: Sat, 14 Mar 2026 11:12:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org, aik@amd.com, aneesh.kumar@kernel.org,
 yilun.xu@linux.intel.com, bhelgaas@google.com, alistair23@gmail.com,
 lukas@wunner.de, jgg@nvidia.com, Donald Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
Message-ID: <20260314111245.76d18d73@kernel.org>
In-Reply-To: <20260303000207.1836586-9-dan.j.williams@intel.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
	<20260303000207.1836586-9-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Mar 2026 16:01:56 -0800 Dan Williams wrote:
> The implementation adheres to the guideline from:
> Documentation/userspace-api/netlink/genetlink-legacy.rst
> 
>     New Netlink families should never respond to a DO operation with
>     multiple replies, with ``NLM_F_MULTI`` set. Use a filtered dump
>     instead.

My understanding of F_MULTI is that deserializer is supposed to
continue deserializing into current object. IOW if we have:

struct does_this {
	int really;
	int have_to;
	int be_netlink;
};

You can send "really" and "be_netlink" in one message and "have_to" 
in the next, and receiver should reconstruct them into a single struct.

If F_MULTI is not set - receiver assumes that the next message is a new
struct. And the whole dump returns a list of structs.

So IOW I think what you're doing is a bit too.. inventive.
Do you have plans to add more commands? 
The read-only stuff feels like it could be a sysfs API?
The main strength of Netlink is "do" commands with multiple optional
attrs.
