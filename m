Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:40543 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbdLMWMg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Dec 2017 17:12:36 -0500
Received: by mail-wr0-f174.google.com with SMTP id q9so3471446wre.7
        for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2017 14:12:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CANn89iJ2UmDTianzVV-c=oyefovOqg_-R9=Hg5hOG9pprKqwmw@mail.gmail.com>
References: <MWHPR12MB1600C4F1693E88236CA8F78EC84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <20171017133702.1b0e35bc@t450s.home> <MWHPR12MB16008EEBF251F321E9B48D41C84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <CAB=NE6U-1ytEbL9A2FeVjcOfN3VSNAJUa9JbsQH9UfjRfANKxw@mail.gmail.com>
 <MWHPR12MB16006DB7914B111AD93FEC10C84D0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <CAB=NE6Xwj20hwX3XzW_bYEby+24c=gY_nQtXPOu1J_c7uRHRjA@mail.gmail.com>
 <MWHPR12MB16004ED0D14F6531DDDD1692C84D0@MWHPR12MB1600.namprd12.prod.outlook.com>
 <SN1PR12MB03524AF87997DFAC404CD514C8350@SN1PR12MB0352.namprd12.prod.outlook.com>
 <CAKdAkRRuX-NcWB_fwWr6XHV61t+L2MCjedfZgaiAD-xpVB-mMQ@mail.gmail.com>
 <CANn89iJ1O+a9-ZUhZK94npGwURpWv8u1aHhVsd0-xEad_+_p8w@mail.gmail.com>
 <CAKdAkRSiVkTo84W7_eDwoLL0UH0jYE7Nbb5D9VEBQS3+UPLXEg@mail.gmail.com> <CANn89iJ2UmDTianzVV-c=oyefovOqg_-R9=Hg5hOG9pprKqwmw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 13 Dec 2017 14:12:34 -0800
Message-ID: <CANn89iL4D7jKAX8Q9tzxPsO+eNdoUqwAJmwTA-hYnqe2=Hd3rQ@mail.gmail.com>
Subject: Re: 4.14.0-rc3 is auto-reloading PCIe SR-IOV Virtual Function device
 drivers when VFs are attached to VMs ...
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Casey Leedom <leedom@chelsio.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Juan Alvarez <jjalvare@linux.vnet.ibm.com>,
        Komali Katari <komali@chelsio.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 13, 2017 at 2:06 PM, Eric Dumazet <edumazet@google.com> wrote:
>> Don't you need to update individual pointers if you are altering the buffer?
>>
>
> Possibly...

I am packing my stuff, before a long flight.

I wont be able to fix this before at least a day, so feel free to fix
this patch ;)

Thanks.
