Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59054 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134Ab2JCE6k (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Oct 2012 00:58:40 -0400
Received: by bkcjk13 with SMTP id jk13so5852730bkc.19
        for <linux-pci@vger.kernel.org>; Tue, 02 Oct 2012 21:58:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20121003031018.GB13391@kroah.com>
References: <1349134020-62152-1-git-send-email-ddutile@redhat.com>
	<CAE9FiQUd=sM3XaMKfJjnJq6mkugL7P=wEjdcMHtGjfe4ooRXUQ@mail.gmail.com>
	<506B4D4C.3080101@redhat.com>
	<20121002203951.GA28663@kroah.com>
	<506B575A.4060304@redhat.com>
	<20121003031018.GB13391@kroah.com>
Date: Tue, 2 Oct 2012 21:58:38 -0700
Message-ID: <CAE9FiQWB-ofvCwHC6q9zUd6zWif79OQyvqdhDsPYFgCA3yxhuA@mail.gmail.com>
Subject: Re: [RFC] PCI: enable and disable sriov support via sysfs at per
 device level
From: Yinghai Lu <yinghai@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Don Dutile <ddutile@redhat.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, yuvalmin@broadcom.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	davem@davemloft.net
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 2, 2012 at 8:10 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Oct 02, 2012 at 05:06:34PM -0400, Don Dutile wrote:
>>
>> So, why is it ok to create the 'reset' file after the device shows up?
>
> It's not, that should be fixed, patches are always welcome.
>

I tried to move "reset" to device type, but it did not work.

Anyway will send out two patches for dev_type and vga again.

Yinghai
