Return-Path: <SRS0=ie6y=GP=denx.de=wd@kernel.org>
Return-Path: <SRS0=ie6y=GP=denx.de=wd@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
    Mika Westerberg <mika.westerberg@linux.intel.com>,
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: PCIe x4 cards not detected on Z370 mainboards
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <20180324044716.GF210003@bhelgaas-glaptop.roam.corp.google.com>
References: <20180322184840.E31D4247251@gemini.denx.de> <20180322192759.GA252023@bhelgaas-glaptop.roam.corp.google.com> <20180323084855.E3EAF247251@gemini.denx.de> <20180324044716.GF210003@bhelgaas-glaptop.roam.corp.google.com>
Date: Sun, 25 Mar 2018 14:28:28 +0200
Message-Id: <20180325122828.7FC55247245@gemini.denx.de>
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn,

maybe it helps to provide some more information.  I can reproduce the
same problem on 3 different mainboards from 2 different vendors:

- Gigabyte AB350 Gaming CF
- Gigabyte Z270X Ultra Gaming CF
- MSI Z370 Tomahawk

I now have all 3 systems ready at hands to run additional tests if
needed.

I have updated the information (lspci output, dmesg output) for all
three boards here:

https://owncloud.denx.de/index.php/s/wXiCMMYJodGj5Kr

Thanks in advance!

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Due to lack of disk space, this fortune database has been discontinued.
