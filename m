Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35380 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbaAWTdP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2014 14:33:15 -0500
Date: Thu, 23 Jan 2014 11:34:05 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Dave Jones <davej@redhat.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [scan-admin@coverity.com: New Defects reported by Coverity Scan
 for Linux]
Message-ID: <20140123193405.GB2605@kroah.com>
References: <20140123184246.GA7461@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140123184246.GA7461@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 23, 2014 at 11:42:46AM -0700, Bjorn Helgaas wrote:
> FYI.  I think the first two (related to "name") are valid.  I haven't
> figured out the "msi_attrs" one yet.

I've send a fix for the first two to you now, that should resolve this
issue.

But the last one, I can't figure out either.  I think Coverity doesn't
realize that we saved off the pointer and can get back to it later on,
as it's a non-trivial pointer chain involved here.

Dave, you stare at Coverity bug reports all the time, can you make any
sense out of the following report:

> Please find the latest report on new defect(s) introduced to Linux found with Coverity Scan.
> 
> ...
> 
> 
> ** CID 1163317:  Resource leak  (RESOURCE_LEAK)
> /drivers/pci/msi.c: 592 in populate_msi_sysfs()
> 
> ...
> ________________________________________________________________________________________________________
> *** CID 1163317:  Resource leak  (RESOURCE_LEAK)
> /drivers/pci/msi.c: 592 in populate_msi_sysfs()
> 586     		msi_dev_attr = container_of(msi_attr, struct device_attribute, attr);
> 587     		kfree(msi_attr->name);
> 588     		kfree(msi_dev_attr);
> 589     		++count;
> 590     		msi_attr = msi_attrs[count];
> 591     	}
> >>>     CID 1163317:  Resource leak  (RESOURCE_LEAK)
> >>>     Variable "msi_attrs" going out of scope leaks the storage it points to.
> 592     	return ret;
> 593     }
> 594     
> 595     /**
> 596      * msi_capability_init - configure device's MSI capability structure
> 597      * @dev: pointer to the pci_dev data structure of MSI device function
> 
> ...
> 
> To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/128?tab=Overview
> 
> ----- End forwarded message -----
