Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34149 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059AbbDKQBy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 11 Apr 2015 12:01:54 -0400
Received: by qkgx75 with SMTP id x75so84883256qkg.1
        for <linux-pci@vger.kernel.org>; Sat, 11 Apr 2015 09:01:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150411073031.GA10481@kroah.com>
References: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150410225426.20848.45696.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20150411073031.GA10481@kroah.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 11 Apr 2015 11:01:33 -0500
Message-ID: <CAErSpo6o46ZDB+KGCKxUYqJKShnjFnU-7P=YdefmzveEH51Xxg@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] PCI/MSI: Rename msi_set_enable(), msix_clear_and_set_ctrl()
To: Greg KH <greg@kroah.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Fam Zheng <famz@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 11, 2015 at 2:30 AM, Greg KH <greg@kroah.com> wrote:
> On Fri, Apr 10, 2015 at 05:54:26PM -0500, Bjorn Helgaas wrote:
>> From: Michael S. Tsirkin <mst@redhat.com>
>>
>> Rename msi_set_enable() to pci_msi_set_enable() and
>> msix_clear_and_set_ctrl() to pci_msix_clear_and_set_ctrl().
>>
>> No functional change.
>>
>> [bhelgaas: changelog, split into separate patch]
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>> CC: stable@vger.kernel.org
>> ---
>>  drivers/pci/msi.c |   28 ++++++++++++++--------------
>>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> How does this, and the other patch you marked for stable, relate to the
> stable_kernel_rules.txt file that dictates what we can take for stable
> patches?

I fat-fingered the stable email address on the patches with the actual
bug fixes, so you probably didn't see them.  The candidates for stable
are patches 1-4 of this series:

      PCI/MSI: Rename msi_set_enable(), msix_clear_and_set_ctrl()
      PCI/MSI: Export pci_msi_set_enable(), pci_msix_clear_and_set_ctrl()
      PCI/MSI: Disable MSI at enumeration even if kernel doesn't support MSI
      PCI/MSI: Don't disable MSI/MSI-X at shutdown

The first two make no functional difference; the last two are the bug fixes.

Bjorn
