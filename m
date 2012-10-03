Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43405 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab2JCRzn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Oct 2012 13:55:43 -0400
Received: by bkcjk13 with SMTP id jk13so6298616bkc.19
        for <linux-pci@vger.kernel.org>; Wed, 03 Oct 2012 10:55:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <506C3B11.9010009@redhat.com>
References: <1349134020-62152-1-git-send-email-ddutile@redhat.com>
	<CAE9FiQUd=sM3XaMKfJjnJq6mkugL7P=wEjdcMHtGjfe4ooRXUQ@mail.gmail.com>
	<506B4D4C.3080101@redhat.com>
	<20121002203951.GA28663@kroah.com>
	<506B575A.4060304@redhat.com>
	<20121003031018.GB13391@kroah.com>
	<506C3B11.9010009@redhat.com>
Date: Wed, 3 Oct 2012 10:55:42 -0700
Message-ID: <CAE9FiQUH9LUwrX2_5zoaDBe3pBHBXC4rOctpNMwGN2nJM5pMRQ@mail.gmail.com>
Subject: Re: [RFC] PCI: enable and disable sriov support via sysfs at per
 device level
From: Yinghai Lu <yinghai@kernel.org>
To: Don Dutile <ddutile@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	yuvalmin@broadcom.com, bhutchings@solarflare.com,
	gregory.v.rose@intel.com, davem@davemloft.net
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 3, 2012 at 6:18 AM, Don Dutile <ddutile@redhat.com> wrote:
> maybe once i figure out the proper sriov sysfs code, I
> can duplicate that effort in the reset,vga & pm-capabilities
> section.

I resent my patcheset in plain mail instead of attached form.

I am thinking we should ixgbe guys to sort out ixgbe change to use
set_max_vfs ops.

Thanks

Yinghai
