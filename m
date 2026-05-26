Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282943D75D6
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787635; cv=none; b=uMadWBF3VegrMEJak6fr+olSoRsSuww28/gsHE4PXi8XGWMNaeJWbZM78tiEcRUhSngWTXJOTo+8gvYHrTj2ypcoQnF6HU201FiRimVc9KVlMaQxeWTREAcD6eb3Up87UqpkUikyxSLsF1JZ5MSDBZ0r8uTdc6APxXd8ksJTjJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787635; c=relaxed/simple;
	bh=Nbw2L11H8OeSwwL79pkT/i8CWBtxF5CaIRrjz2ju7FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THRV1Nn76HC3OW/MCm3965WhTG24DHVkn+WHNR0i/7z8xBkY1TkfzyFgNxAOngDQ153jEpjXIKdyL8C7BqOYo1NWro12cJqV0piQcxsOkmSVm8F9df0VDetALtcrXWf4qh9OTjkz9qkO/cybqcLbmQQ9tH1bpT605UFgr1vK1JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sNpVhMs1; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sNpVhMs1"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779787625; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=RR4lUZdYoL3Vw06ZGP2CnNvK2bEQNqhFe15x28HIaWg=;
	b=sNpVhMs1G7R+xFHrgNqoY767+x0Kdhl0bzGXLypc4UyfD9iRliRogUb/WkWPOYYI8AzLhZWZUDMECtZM9BgEnN+j6ZaToLJ8tcC2kTJltOSEMNoB8eDtiuPYQtZs/JdctleHU8hsCT1IRpLdgI6uHdd/xBJoHz5potzGP5J3Wbs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X3fq5Z7_1779787612;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X3fq5Z7_1779787612 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 May 2026 17:27:04 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: sashiko-bot@kernel.org
Cc: cp0613@linux.alibaba.com,
	linux-pci@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH] cxl/acpi: Defer probe when ACPI0016 PCI root bridge is not ready
Date: Tue, 26 May 2026 17:26:46 +0800
Message-ID: <20260526092652.171319-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526031200.C19341F000E9@smtp.kernel.org>
References: <20260526031200.C19341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

On Tue, 26 May 2026 03:12:00 +0000, sashiko-bot@kernel.org wrote:

> > +
> > +	/* Clear _DEP dependencies to allow consumers to enumerate */
> > +	acpi_dev_clear_dependencies(device);
> > +
> >  	return 1;
> >  
> >  remove_dmar:
> >  	if (hotadd)
> >  		dmar_device_remove(handle);
> >  end:
> >  	kfree(root);
> 
> [Severity: High]
> This is a pre-existing issue, but does the dmar_device_add() error path
> leave a dangling pointer in device->driver_data?
> 
> Earlier in acpi_pci_root_add(), the allocated root object is assigned to
> device->driver_data:
> 
> 	root->device = device;
> 	root->segment = segment & 0xFFFF;
> 	device->driver_data = root;
> 
> If dmar_device_add() fails during a hot-add, the code jumps to the end
> label and frees the root pointer via kfree().
> 
> However, it doesn't explicitly reset device->driver_data to NULL, unlike
> the later pci_acpi_scan_root() error path. Since the ACPI core does not
> automatically clear driver_data on an attach failure, could subsequent calls
> to acpi_pci_find_root() by other subsystems fetch and dereference this freed
> pointer?

Good catch — you're right. On the dmar_device_add() failure path, the
code jumps to end: and frees root via kfree(), but
device->driver_data is left pointing at the freed memory. The later
pci_acpi_scan_root() failure path explicitly clears it to NULL, which
makes the omission on the dmar path look like an oversight rather than
intentional.

Since this is unrelated to the _DEP clearing change in this patch, I'd
prefer to keep it out of this patch and send a separate fix on top. Both
failure paths converge at end: and need the same cleanup, so I plan to
consolidate the NULL assignment there:

@@ -724,7 +724,6 @@ static int acpi_pci_root_add(struct acpi_device *device,
		if (!root->bus) {
				dev_err(&device->dev,
						"Bus %04x:%02x not present in PCI namespace\n",
						root->segment, (unsigned int)root->secondary.start);
-				device->driver_data = NULL;
				result = -ENODEV;
				goto remove_dmar;
		}
@@ -764,6 +763,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
remove_dmar:
		if (hotadd)
				dmar_device_remove(handle);
end:
+		device->driver_data = NULL;
		kfree(root);
		return result;
}

This way every path reaching end: clears driver_data before freeing
root, and any future error path that does goto end; is automatically
correct. Does that split sound OK to you?

Thanks,
Pei
