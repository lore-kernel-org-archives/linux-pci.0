Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:39194 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbbBCJZo convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-pci@vger.kernel.org:8:2>);
	Tue, 3 Feb 2015 04:25:44 -0500
Message-Id: <54D0A226020000780005C43F@mail.emea.novell.com>
Date: Tue, 03 Feb 2015 09:25:42 +0000
From: "Jan Beulich" <JBeulich@suse.com>
To: "Bjorn Helgaas" <bhelgaas@google.com>,
	"Yijing Wang" <wangyijing@huawei.com>
Cc: <david.vrabel@citrix.com>, <yinghai@kernel.org>,
	<xen-devel@lists.xenproject.org>, <boris.ostrovsky@oracle.com>,
	<konrad.wilk@oracle.com>, <alex.williamson@redhat.com>,
	<kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: Add guard to avoid mapping a invalid msix
 base address
References: <1422503683-19709-1-git-send-email-wangyijing@huawei.com>
 <20150202210626.GC5176@google.com>
In-Reply-To: <20150202210626.GC5176@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>>> On 02.02.15 at 22:06, <bhelgaas@google.com> wrote:
> I applied this to pci/msi for v3.20, thanks!  I reworked the changelog as
> follows; let me know if it still doesn't make things clear:

Thanks, looks good to me now.

Jan

